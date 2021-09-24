module.exports = {
    root : true,
    env  : {
        es2021 : true,
        node   : true,
    },
    parser        : '@typescript-eslint/parser',
    parserOptions : {
        ecmaVersion : 12,
        sourceType  : 'module',
    },
    plugins: [
        '@typescript-eslint',
    ],
    extends: [
        'plugin:@typescript-eslint/eslint-recommended',
        'plugin:@typescript-eslint/recommended',
        'airbnb-base',
    ],
    rules: {
        indent            : ['error', 4],
        quotes            : ['error', 'single'],
        semi              : ['error', 'always'],
        'max-len'         : 'off', // disable line length checking
        'no-multi-spaces' : 'off',
        'key-spacing'     : ['error', {
            align: {
                beforeColon : true,
                afterColon  : true,
                on          : 'colon',
            },
        }],

        /*
            < for..of문 허용 >
            Airbnb에서 Symbols 폴리필 문제로 사용 금지한 규칙 중 하나이지만,
            Node.JS 최신 버전에서는 문제 없을 것으로 보이므로 해당 규칙을 해제한다.
            https://medium.com/@paul.beynon/thanks-for-taking-the-time-to-write-the-article-i-enjoyed-it-db916026647
            https://github.com/airbnb/javascript/issues/1271
        */
        'no-restricted-syntax': 'off',

        // TypeScript: Import 경로 문제 수정
        'import/extensions': ['error', 'never'],

        // TypeScript: 함수 리턴 타입 명시 해제
        '@typescript-eslint/explicit-module-boundary-types': 'off',

        'no-console'  : process.env.NODE_ENV === 'production' ? 'warn' : 'off',
        'no-debugger' : process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    },
    settings: {
        'import/resolver': {
            node: {
                extensions: ['.js', '.jsx', '.ts', '.tsx'],
            },
        },
    },
};
