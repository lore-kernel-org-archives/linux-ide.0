Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF540D590
	for <linux-ide@vger.kernel.org>; Tue,  9 Jun 2026 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039858; cv=pass; b=BiCWIObf1mpog5EdaMWNwsUwHIVOQ134Rdy2NOiptotlLTs9wzcEKYXm+HaAui40waSJu+gL93zwfGaIYXS0W88/5zjv9kp+18u3VSYuNsptS1qG43u4cDfc3IHxJA46KSytf8bHVu+WBEmHy4K0nGhhhDiioAhnELhsC2lpYmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039858; c=relaxed/simple;
	bh=xE+PMfDF5qcgxg6NwIwP6SPxixCoplPyYZdVm69xlLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAHaeOfkAfp/DD63lUicMX2wQy6a+FGlt7/f1orbOGgLEGxi6A/9PRLqng4SwtbehB8B2Wh79+Ec+SUiCtFkCxoK0Ye4kG1mfD/aaKmlj74F+S6tSvLtQ3SfCVAcWW7mOmGL1gjWRbpjKINlD5DM1CHYdst5BJEEbNQZdlZLteo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1anG3/5; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1anG3/5"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6913fb25322so4937109a12.1
        for <linux-ide@vger.kernel.org>; Tue, 09 Jun 2026 14:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781039856; cv=none;
        d=google.com; s=arc-20240605;
        b=QO3FWW4/KhBj5UH8PMC9+NDnv0sUMI81sIavAYTCfPtgMDipv5phA9eShJdUoAmGcJ
         EOVgpBfXnPM83lFFBACTJJ1zMwEAYqpfxFo7tYjj3Tra2AtwtwTe0AzMxVubQ5r21o3W
         KHS4XPJLn77niKjeeyRzZUZ2XjY8HuTlUviWhqolgdBS7UxXnQL9N34SiISyV5LX/Y5J
         AzSD/3afafyczdgisneVThvP2tdGJP9gOsg98pkl+ob//wSFZpL8+w4TdNBlCiGEMMkG
         YKMQzHrGddulgs81lPBOhTRidQeTsJNb/QV2/whc04LBSodFREqcYtYX2mtv2Egmo6qT
         0rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PdUY8uP8CGPpNcVHpvwPxAK89CllH5IggAxzGZy7ifU=;
        fh=Cg11x86Ma+KjQ0chDZtQb2Kj3iaXjQ8K+6XhHzIfE/A=;
        b=bmg95kstaF3hfghBp4PtxX70JHDO48ydvdXLb5WVpJ5T3kUpqc83e8KwhEz28b0g+Y
         TXlWfD40QHGxYLdQezl1KZC+hX9mSk+ByUr/rBwsCCSW8eGQpM/ANluzBW+IFOS7h6ok
         o0Gb2SSXhVXbR2CopYoy86GmxZIpjf7K+l77xXioLwm+PxVDlK6COgsEolzh8FrYU/7H
         dU37xsHvmx7qLDvIqEBKtFTDqIDP//erQX8CNAE6kyyVDV/B4iKvxAVtA79w0+06zvMZ
         /Yyjzi71KBuBax/KpmlWDKckBr8e3BNObdsTfwezos4R5PWAnlB1NUHI2Tq31fyDZDPI
         J9Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781039856; x=1781644656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdUY8uP8CGPpNcVHpvwPxAK89CllH5IggAxzGZy7ifU=;
        b=j1anG3/5t+J4+tcIbQ+NRQPhWAVaPIu9Df2FrhhXDV7j1z8VZDOKoYCvxUFzaynV9O
         2bSiUJ6GyfvI14pHTWpdkd4PjmqymRSlj+XURNvcw7kik9PS8HsJ+++uMtbT69xp4zIQ
         xfC4Lmn9kIbUMzwENxQ9Y0YGSXejdHfv1P82l2d0mtqE9jHzWpV3rVV9RxIsbRqSy/Eh
         aCPJy8XvQwEEZ6clYuDplN9/sVhNhLKtnniWI6TJNwsupuxBWp8VEk7gpHt+rwJw/JGS
         hJECHGtv74gdCUVlJfnRd7ZIFVfJo+IsxJm5H2DPd8SFsSgPsXJOw0FE1slYZBuw4tyN
         poOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781039856; x=1781644656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PdUY8uP8CGPpNcVHpvwPxAK89CllH5IggAxzGZy7ifU=;
        b=Ln1RONoz1h9gVCmJcbUadPOqBDYTSvXzIyGbtCpR5M4tMoXNs09Lt1vqOL+AyrVUze
         sTeSFUQtNZ3KLboHX6zVo/yGxK5CEHLi37up9iTJar3MBisi0fOSFlGuFiJgWgisy/UL
         509hNO8bC8OOobICUybW9e+xXFEb1j3Rb8zjsF++mZGpg7NzmL63oaxK7lczM8spozor
         Xq1Jk55QWSHNJfvp46LJw0tHWnYQqE+Dew/T74z5Mu3uNOUh9qFFbTQSqB+sIlcKhxKK
         BDbVpkGkIC8a10EWN37RGMa8BBhOSlLmFRmF8oCJ/5/mWtgqVRLZHfmlfgphy1quIRs3
         y6Wg==
X-Forwarded-Encrypted: i=1; AFNElJ+e0wZDsadyFPd3rf3EncOVV17Ut4Evs1OniUQZDN+IX+hTIKtLcAVFKtGjpmAM6pUR6DywDF+k6Go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+eyHzwBsSnxBYLneMTsdkz1RqxqtmK2lQq2m9yhkrSGd1W6Pi
	cnDfWWimp1WRykq0d3hxbOYUrlyREaSFLjDsO9riKzERQp1K97gurcTFWwcPzGATUVf9M6LjY6e
	cHe0R25WCFzQWAiP5ao4quhyGKvfdBB7f39BZQWM=
X-Gm-Gg: Acq92OHa/KyFoeNQcgqIBLrPN38B6ktOMsKJ5qQYsGEzKHdDzF6o+/LqBZp/7TiRBvQ
	cncJnim3DjTXWGi4t2Y8w/2nEB6UjyZHrOBMTEWofdrv/970G439HWJrpC/B7vxL4eBCTz1T/PD
	1MUDDSFiCKyvdgSXT86CfmWLL8Os49Kk8BkN+jQeA/RfDwoZCdTVvVVVTiRzLwU5Atd4aCeYF2T
	OMzctQP3SvOjWhbm7W3BP5WKaT+O1SXBf49IXhJ3Qgx7H9jlbKx6Xk76U3Jk/a5Lp1uFBFUWuYX
	B6Ban39WT4J5OTz907VAkGFc1+a7tbtaA5nhJ7mbBFzdpJtL0MhNPGJvZkE1KHydCYuDIGtSxW4
	IsnYllxW9E955IIdSNKPbNKfP/aRcAFD6ps+wVig3eGXAsiu0UWXAQX+u0fLdbVfPkV09
X-Received: by 2002:a05:6402:27ce:b0:687:5157:1d4f with SMTP id
 4fb4d7f45d1cf-68fa524d249mr9996781a12.26.1781039855727; Tue, 09 Jun 2026
 14:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608214718.49503-1-rosenp@gmail.com> <20260608214718.49503-2-rosenp@gmail.com>
 <aie-w7BTHYYwTKvq@ryzen> <aifQgZwd8KzUOuKl@ashevche-desk.local>
In-Reply-To: <aifQgZwd8KzUOuKl@ashevche-desk.local>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 9 Jun 2026 14:17:24 -0700
X-Gm-Features: AVVi8CdOvnoQksXaLioEwW_ehXSfYSqRqKiq7J1GAGF2cnZX2OaySUQtjQixRaI
Message-ID: <CAKxU2N9kAe4Yc1iE7r0Gw=CyQWuaWwwN5uUBV_J0szAF90G3BQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ata: pata_mpc52xx: switch to non-devm request_irq for
 proper ordering
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Niklas Cassel <cassel@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-ide@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 1:36=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Jun 09, 2026 at 09:20:35AM +0200, Niklas Cassel wrote:
> > On Mon, Jun 08, 2026 at 02:47:15PM -0700, Rosen Penev wrote:
> > > The BestComm task IRQ handler accesses priv->dmatsk, which is freed
> > > by bcom_ata_release().  With devm_request_irq(), the handler remains
> > > registered until devres unwinds after the error/remove function
> > > returns, creating a window where the handler can access freed memory.
> > >
> > > Switch to request_irq() / free_irq() so that the interrupt is
> > > unregistered before bcom_ata_release() tears down the task.
>
> ...
>
> > >     task_irq =3D bcom_get_task_irq(dmatsk);
> > > -   rv =3D devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq=
, 0,
> > > -                           "ATA task", priv);
> > > +   rv =3D request_irq(task_irq, &mpc52xx_ata_task_irq, 0,
> > > +                     "ATA task", priv);
> > >     if (rv) {
>
> > >             dev_err(&op->dev, "error requesting DMA IRQ\n");
>
> Side note: In case we leave devm_request_irq(), this message is a dup
> and may be removed.
>
> > > -           goto err2;
> > > +           goto err_free_task;
>
> Now, devm_*() should be never followed by goto. If we want to keep devm
> approach, the original code has more issues.
>
> > >     }
>
> ...
>
> > Andy, since you gave a talk about this recently.
> > Surely there must be a better way than to migrate away from the device
> > managed APIs.
>
> Thank for Cc'ing me.
>
> > Do you have some suggestion?
>
> This patch either way (are we going to devm fully or rollback to non-devm=
)
> is half-baked.
Note the fixes tag. The purpose is to get this backported.
>
> What I may suggest here is to extend this patch to cover the second
> problematic place (*) and make it as a fix for backporting.
>
> After that one may carefully go and finish converting probe to devm_*().
>
> *) https://elixir.bootlin.com/linux/v7.1-rc7/source/drivers/ata/pata_mpc5=
2xx.c#L733
> The call of irq_of_parse_and_map() should be moved after devm_kzalloc().
> So, this fix should do what it does + the above.
Doesn't matter much. task_irq gets requested, not ata_irq.
>
> P.S.
> Someone may tide up this driver a lot, but this is out of the scope of
> this patch. FWIW, the brief list of potential refactoring patches
> based on probe (in unsorted order):
> - use devm_platform_ioremap_resource()
Done in later patch in this series.
> - moving towards device_property_read_*()
> - using dev_err_probe()
> - use temporary variable to hold struct device pointer
> - use fwnode_irq_get()
> - apply multipliers from units.h and time.h (like HZ_PER_MHZ)
> - moving to a new struct dev_pm_ops and pm_sleep_ptr() macro
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
