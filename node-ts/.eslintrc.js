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
        project     : './tsconfig.eslint.json',
    },
    plugins: [
        '@typescript-eslint',
    ],
    extends: [
        'plugin:@typescript-eslint/recommended',
        'plugin:@typescript-eslint/eslint-recommended',
        'airbnb-base',
        'airbnb-typescript/base',
    ],
    rules: {
        indent             : ['error', 4, { SwitchCase: 1 }],
        quotes             : ['error', 'single'],
        semi               : ['error', 'always'],
        'arrow-parens'     : ['error', 'as-needed'],
        'no-empty'         : ['error', { allowEmptyCatch: true }],
        'max-len'          : 'off',
        'no-continue'      : 'off',
        'no-await-in-loop' : 'off',
        'no-multi-spaces'  : 'off',
        'key-spacing'      : ['error', {
            align: {
                beforeColon : true,
                afterColon  : true,
                on          : 'colon',
            },
        }],

        'object-curly-newline'   : 'off',
        'class-methods-use-this' : 'off',
        'no-restricted-syntax': 'off',

        // 클래스 멤버(변수 & 함수)사이에 빈 줄을 넣는다. (단, 한 줄인 경우는 제외)
        'lines-between-class-members': ['error', 'always', { exceptAfterSingleLine: true }],

        '@typescript-eslint/indent'                         : ['error', 4],
        '@typescript-eslint/explicit-module-boundary-types' : 'off',
        '@typescript-eslint/lines-between-class-members'    : 'off',

        'no-console'  : process.env.NODE_ENV === 'production' ? 'warn' : 'off',
        'no-debugger' : process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    },
};

/*
    'no-restricted-syntax': 'off' // for..of문 허용
    Airbnb에서 Symbols 폴리필 문제로 사용 금지한 규칙 중 하나이지만,
    Node.JS 최신 버전에서는 문제 없을 것으로 보이므로 해당 규칙을 해제한다.
    https://medium.com/@paul.beynon/thanks-for-taking-the-time-to-write-the-article-i-enjoyed-it-db916026647
    https://github.com/airbnb/javascript/issues/1271
*/
