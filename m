From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] ata: increase retry count but shorten duration for
 Calxeda controller
Date: Fri, 31 May 2013 08:53:37 +0200
Message-ID: <51A848F1.3040301@ladisch.de>
References: <1369923509-3246-1-git-send-email-mark.langsdorf@calxeda.com> <51A76197.9080708@calxeda.com> <51A7646B.6080203@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51A7646B.6080203@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Timur Tabi <timur.tabi@calxeda.com>, Mark Langsdorf <mark.langsdorf@calxeda.com>, tj@kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> On 30-05-2013 18:26, Timur Tabi wrote:
>>> +    const unsigned long timing[] = { 5, 100, 500};
>
>> You'll save space and time if you also make this array "static",
>> otherwise the compiler will build the array every time this function is
>> called.
>
> No, *const* specifier is enough to not build this array every time. It will be put into the .const section.

gcc disagrees:

$ cat const_static.c
int f(int x) {
	const unsigned long timing[] = { 5, 100, 500};
	static const unsigned long timing2[] = { 5, 100, 500};
	return timing[x] + timing2[x];
}
$ gcc -Os -S const_static.c
$ cat const_static.s
	...
timing2.0:
        .long   5
        .long   100
        .long   500
	...
        movl    8(%ebp), %edx
        movl    $5, -16(%ebp)
        movl    $100, -12(%ebp)
        movl    $500, -8(%ebp)
        movl    timing2.0(,%edx,4), %eax
        addl    -16(%ebp,%edx,4), %eax


Regards,
Clemens
