From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Revert "ata: sata_mv: Convert to devm_ioremap_resource()"
Date: Wed, 31 May 2017 01:53:29 +0200
Message-ID: <CACRpkdY0eJE5EdrahNbSucM2ERQJBwfP5q01LDaYUR9CJaiZsg@mail.gmail.com>
References: <20170530135256.9966-1-linus.walleij@linaro.org> <1496152548.28981.25.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1496152548.28981.25.camel@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, stable <stable@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, May 30, 2017 at 3:55 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, 2017-05-30 at 15:52 +0200, Linus Walleij wrote:
>> This reverts commit 368e5fbdfc60732643f34f538823ed4bc8829827.
>>
>> My NAS stopped to mount root when I went from some v4.10-rc1
>> to v4.12-rc3. Investigation of the bootlog yields this:
>>
>> sata_mv f1080000.sata: can't request region for resource [mem
>> 0xf1080000-0xf1084fff]
>> sata_mv: probe of f1080000.sata failed with error -16
>>
>> Reverting this offending patch makes the sata_mv probe and
>> my SATA drive can mount root again, hooray!
>
> It's already in upstream (ata tree).

OK!

Only two patches for the same issue? Today for the GPIO
tree I got four (4!) patches fixing the same issue :D

Yours,
Linus Walleij
