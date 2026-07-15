Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4A197A7D
	for <linux-ide@vger.kernel.org>; Wed, 15 Jul 2026 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101255; cv=pass; b=ONPdE/meX7MQOJrHEZSAyW2Re7wCQ8Nol3WwbSz9FWo/+AtyUANg+bzbI/fzZ1YB2Gr7lSrwCAhAGkAm7Br2EfOM2bYpJnyhB2OrpqsSHe6Bm4YNt9rDVXi9QWbI1M3hi1Nhli2XV+8HybmrBhu4u2EKVEQusPduzMIzsLlcCqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101255; c=relaxed/simple;
	bh=VLBm+FQw5zA3Od1xp4Nlme+26/ycNp0KTsQMk90JYbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QJ+SbyfzHCbHLPppwOb/VHN5dMhUmTux4aik17Gt3KUoJuA2/Iqt84jpuY+IabaLupu5JTONJPW2XXpLku9ltx/dXRWK8hw9czyJRfh83hN2/uK+hU7CwyxAFUF9s9beOXEcAbUNfuZXo5rvhV/NvS70wvhMlLJZf+iPMa5zp6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rkjnsn.net; spf=none smtp.mailfrom=rkjnsn.net; dkim=pass (2048-bit key) header.d=rkjnsn-net.20251104.gappssmtp.com header.i=@rkjnsn-net.20251104.gappssmtp.com header.b=Yg3ER3XC; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rkjnsn.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rkjnsn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rkjnsn-net.20251104.gappssmtp.com header.i=@rkjnsn-net.20251104.gappssmtp.com header.b="Yg3ER3XC"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69c19a37eeaso10184392a12.2
        for <linux-ide@vger.kernel.org>; Wed, 15 Jul 2026 00:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784101250; cv=none;
        d=google.com; s=arc-20260327;
        b=DVtFUOTp8uBWLYCaP6JRZHNgdppAYDPPwM3SWTzqDgUVqdRlFGexlKcQSEh1JrsVn8
         m4tD/HMaj4ecaDXgOTDbPQsN/dU8nbFoX+8q0cBa77SdkiOTxd3t4L5tptQroibKQmbG
         RbUKBuy4jz+iYBddwbq5COSekNIuqAlwY/YCQvAkRhI1lfoLBZ+Uv1dJSWvMGSSr5mWx
         6+1wXaNVTS6xTbq+cGow57RWW3oxnlUf2YHPkXSgCTa1IMEvL10ho3qI4RtNSyvuQ84v
         0vQOsF9GkG0dfsyQhw9Y4SNnA5BLRCOxNPzhVolrvDZq3icbAcX1uOXuGi8aUIJSKCps
         X/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VLBm+FQw5zA3Od1xp4Nlme+26/ycNp0KTsQMk90JYbQ=;
        fh=ztqLSSfhfzwf5R5ueAL3RXPewrpq9XyecaQfGUPz7Y4=;
        b=Vg5c/mUz9VnTEMJZM8RnF8eNapc8hsX607eiJb0XM12nDKNv1GQ38w46zpHB5P7sRP
         jQPkdgZM/CpKc4nK7acXl5mZyKz/sdAFwMxOD9S67hG/iez0K1qgFV0FVRSClGMMJq9L
         zTdxLFMOYPBAXm42TWRtxfuS4lcgTD/YaszJtML1J5D2qRJtj6rquW6kuVbnpn2J+0CT
         fOWsgN6OUoJjxRdz981fKEyWEyHBbWrGIjLzZl2rqj10zvHlaqvrcLhlBjbwUx5Y5WrM
         zAoOdRA5sIMzRzF6cSeZqTG4BGNrnSqlzntFFkdEVHs2aDmr7O3/X63V41Zq+sNj9yll
         B2GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20251104.gappssmtp.com; s=20251104; t=1784101250; x=1784706050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VLBm+FQw5zA3Od1xp4Nlme+26/ycNp0KTsQMk90JYbQ=;
        b=Yg3ER3XCgWTounMADd4X1R3HG4H9pjfAtzMclHs3bgfH0Q+10559Bk2RvMv30API1p
         nk82+HYqtWgtcNcWPAwlBjur9CZ0aWHSp+vQvYxoOb3pfz8eRodgL4vZPC5d+3DaeHpm
         8GCnZj7AI5yO9jSaRyizBv7lxjaHLFeYofWoRJ6hwNP9csVJnncjE6XBQBOtR3OhN/K3
         uG51ukaPbQi4kq1qDbNgPldh7jkhs6dazQfTBvuzFRt3YWK2R4Z8vBYMIVJyS8yZlJbt
         vof22679+KJanvD5c8Zu/4LcfMYNrkHcII+wZDlCIdth+LzARtCOBfJ8M7se7xGZGvYy
         xaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784101250; x=1784706050;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VLBm+FQw5zA3Od1xp4Nlme+26/ycNp0KTsQMk90JYbQ=;
        b=jHRWpf7uzhZlXGVkgkXNuKk3/vZJfh//eWv7eAJqPgS3w3Safd9lvWPUh1XCj4FGBn
         VBppeCKkskTGs5yuA4Xa6d6leCctptAws+vgUAGS1FEPfcUUY1ES2/03rhXQK4LV9a2o
         sNi3NXzh5LPKaMchXOLBaRLhmGNHIZxk9RsDmSykQMEeYhbghdaZhxxFbvUDk9H0/VZb
         kRn7nnL61/HXNgmFW7WhQK2x6DqgxBYEoiF/ueK4Z23ez32ssj+qW0MNJb7j3ucE0E+i
         uCs28HVFYJrAsrPLpD1Wu8p709e248TzDuM/7CqsTjHJV9nUANWLoxfd6xL70+If7yPW
         ssAg==
X-Gm-Message-State: AOJu0YwFZpqJLFpz46fCXtrjC0x74UYjZrNPIfFW/kEZIZAq6VbZ8YAQ
	B2ElaogxAroHrtu7wvJu6pk3roPjKm99VusznEhJ3Q93IXZvvbKFicSiQs7ITTWPqugNwIkbuuK
	xKLZwYe25I7p6G2paclLmMGA1LaNOpdOXnkcLlphr2UDrvKyHj3rq04o=
X-Gm-Gg: AfdE7cn/9GulyfjYBKAxhTvVdcQPRRSZi66Lw18YT1/zdK4m32P/ldkVgPwUAVsJjy6
	fWjQu6kIHtCQtczSHdCgXVQNSOur/qVhpou5JFvxjbZe/x/9bvMF7VH1fjqN0ggvzozz7sCVidC
	zUzSjCbXWyTeGyT9yyqT0SuXUwAC/UtaV60f3mdwz5hH2R67nDVgkmTVYR8N2LM6uGUMGj3wlA0
	jr2yid7HkixlufHJGYxIaZAl0dqVepMn3/9Fivcp+00qtsgdt2oe5H+uZY/cxl9tg+D239lBuTo
	Sb3nlQPf
X-Received: by 2002:a05:6402:3229:b0:698:3365:f950 with SMTP id
 4fb4d7f45d1cf-69cd2b3e980mr3792237a12.21.1784101249857; Wed, 15 Jul 2026
 00:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj6ewPbSgK6VnW91OG14Var4pBbeaZ5_+02znScvdk47Cm+Rg@mail.gmail.com>
In-Reply-To: <CAMj6ewPbSgK6VnW91OG14Var4pBbeaZ5_+02znScvdk47Cm+Rg@mail.gmail.com>
From: Erik Jensen <erikjensen@rkjnsn.net>
Date: Wed, 15 Jul 2026 00:40:37 -0700
X-Gm-Features: AUfX_mxTXfxcWp7JmboeBRkIl9NFWDLw1vZn0glsjvv0ZGFddPgDGel_U__b7QM
Message-ID: <CAMj6ewMkjij8FcdRBveU5Q-xudEyBS+q01y_KeCxgCBO9D_Pgw@mail.gmail.com>
Subject: Re: Drives sometimes come up at wrong speeds / how to force COMRESET
To: linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Realized that

echo "- - -" | sudo tee /sys/class/block/sdX/device/../../scsi_host/host*/s=
can

does what I need. (For some reason I had it in my head that that
wouldn't reset the physical link, which it does.) One drive comes up
with a slow link, run that, and it fixes without dropping any of the
others.

Sorry for the noise.

On Mon, Jul 13, 2026 at 2:14=E2=80=AFAM Erik Jensen <erikjensen@rkjnsn.net>=
 wrote:
>
> I have three drives connected to an ASM1164 Serial ATA AHCI
> Controller. Due to whatever quirk of the initial link training, often
> at least one of the drives will come up at a lower speed than it
> should. E.g., maybe the first drive will come up at 1.5 Gbps, or the
> third drive at 3.0 Gbps. When they do all come up at 6.0 Gbps they are
> absolutely rock solid (many terabytes of data over multiple days with
> nary a hiccup).
>
> My current workaround is to echo the PCI ID to
> /sys/bus/pci/drivers/ahci/unbind and then
> /sys/bus/pci/drivers/ahci/bind. The trouble is that since more often
> than not, at least one of the drives comes up slow, it can take
> several attempts before all of the drives are up at 6.0 Gbps.
>
> Is there a way that I missed to force a COMRESET on just a single
> drive to get it up to speed without risking knocking down the others
> that are already correct? If not, is a sysfs entry to do so something
> that could be accepted? (Perhaps /sys/class/ata_link/linkX/force_reset
> or /sys/class/scsi_host/hostY/force_reset or similar.)
>
> Thanks!
