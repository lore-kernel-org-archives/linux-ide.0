From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] libata: Fix devres handling
Date: Tue, 30 May 2017 11:21:24 +0200
Message-ID: <CACRpkdY696hTcdDwoCg6GPi_VG7Q=iC8yt8iJQMQ5FYQ_S3fqw@mail.gmail.com>
References: <20170519230314.15718-1-linus.walleij@linaro.org> <20170523211608.GJ13222@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170523211608.GJ13222@htj.duckdns.org>
Sender: stable-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, stable <stable@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, May 23, 2017 at 11:16 PM, Tejun Heo <tj@kernel.org> wrote:

>> The ATA hosts are allocated using devres with:
>> host = devres_alloc(ata_host_release, sz, GFP_KERNEL);
>> However in the ata_host_release() function the host is retrieved
>> using dev_get_drvdata() which is not what other devres handlers
>> do, instead we should probably use the passed resource.
>>
>> Before this my kernel crashes badly when I fail to start a host
>> in ata_host_start() and need to bail out, because dev_get_drvdata()
>> gets the wrong-but-almost-correct pointer (so on some systems it
>> may by chance be the right pointer what do I know).
>>
>> On ARMv4 Gemini it is not:
(...)
> This is really weird.  The two can't be different, well, at least
> shouldn't.

I found the problem.

This is because my driver issues platform_set_drvdata(pdev)
on the same struct device * overwriting the data with
its own. That function is just an alias for dev_set_drvdata().

Amazingly, libata survives this until release.

Maybe we should print a warning if dev_get_drvdata()
and res differ? It's a sign that something is wrong because
someone screwed with the drvdata behind the back of
libata.

It appears further that I am in bad company: there are a few
drivers in drivers/ata that have broken errorpath because
they do exactly this or variants of this. So it turns up in my
driver too because of copypaste.

Device drivers assume that they "own" drvdata inside the
device, but with libata they do not, as shown above.
It is used more as a rule than an exception to pass a
state container from probe() over to remove().

It is a common pattern to overwrite drvdata, the following
drivers now have this bug in one way or another:

pata_bf54x.c: platform_set_drvdata(pdev, host);
pata_ep93xx.c: platform_set_drvdata(pdev, drv_data);
sata_dwc_460ex.c: dev_set_drvdata(&ofdev->dev, host);

These drivers:

pata_rb532_cf.c: platform_set_drvdata(pdev, ah);
pata_samsung_cf.c: platform_set_drvdata(pdev, host);
sata_fsl.c: platform_set_drvdata(ofdev, host);

They set the ATA host as drvdata, essentially overwriting
the drvdata pointer with the same value.

I guess I will simply make a cleanup series for these,
making sure they use host->private_data instead and do not
double-write the drvdata.

Yours,
Linus Walleij
