Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A729D3D9543
	for <linux-ide@vger.kernel.org>; Mon, 13 Jul 2026 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934097; cv=pass; b=NzxmyVJ2gZdEqC0WGZdV8pOTTjhIHzx7JEInWjCnXGRugjy8x7FE2EVujJfHOhgjvvHWxnDsGTy/OCnkMqCWl57ko4xzzYqNHZY/DGztXLUVYE+WBKnh2IV/y/GS5OQd/rLa8ULVkSkkI4h/R92j0Xm9NX+M3dxCuwQduYiFHEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934097; c=relaxed/simple;
	bh=7gzkUPb1I6tE3E463cEtpSwu2IGZOQU1xcbEhICObCk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LSzAt4HDgiEiGlDuWGB6xGAEj4WJWDYPeu5P6vM4U9Oyu02i+/CigqRDeUgOSuddrBJfbA7RJCBDPp7SxWTnKW+lGXuTAaYQpE+CKEe/CQbMLfkmH6uazt9TMqe0d2pAQR/M4re4/0txReuUYvHAHDmKWHjPYvQwqo1MqQn4BmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rkjnsn.net; spf=none smtp.mailfrom=rkjnsn.net; dkim=pass (2048-bit key) header.d=rkjnsn-net.20251104.gappssmtp.com header.i=@rkjnsn-net.20251104.gappssmtp.com header.b=U98dc7Iv; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rkjnsn.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rkjnsn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rkjnsn-net.20251104.gappssmtp.com header.i=@rkjnsn-net.20251104.gappssmtp.com header.b="U98dc7Iv"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69a5ecbbfb2so4350350a12.2
        for <linux-ide@vger.kernel.org>; Mon, 13 Jul 2026 02:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783934089; cv=none;
        d=google.com; s=arc-20260327;
        b=Zu1F4ZGURMh9gUjR2xO6mWE+vIzeO0y2tjGRXnsXSIupUssxWzobX9CijjDuyaySa6
         yVnf98nCfS/V4uwOf4Fbe7l5F98icJIrkY84irKr9V01M15q2fNJJiNiMJMOqEO3Dg9W
         O42+jqtWKi+qtmVxWTjutEc524BYWU0jsGDiF0mwRv5bn0lrNk1h5UrkqfzHFWMVE/qW
         hjds/Btk1u1tawA2nw61GCBdaa7qgNhHF5qX0RnAA85tyKjnYMUObNO2UIEX4+NA71um
         ksVh3+uMAIK+vKyOKYh9k6Kt233j0BSPuF0SFwy6YHhkI4NTqo+KMBNZuNXYSNgpSnUb
         o5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7gzkUPb1I6tE3E463cEtpSwu2IGZOQU1xcbEhICObCk=;
        fh=ztqLSSfhfzwf5R5ueAL3RXPewrpq9XyecaQfGUPz7Y4=;
        b=LHm1xK3qJq18qjwizTg2zyPXNBosGLJa7pqwP4e3SKB/O5c8U9sO+7gh6uWZIyg5iA
         JA/ppZ0QTvKy+aT4xOPcVizwZeitbpKjx8YKWpLgWYJqlmU7Hl2FW03xArvjvUeuSYUY
         Sq9gmwI4HtmRx6Ake5EVQ9p90N3f7v8HOZ4j/mfq6y00VdRKDTjRTrevDqHOYB/JV4+w
         TzrUIdYLWbSAZ0dbfD7xP4lgChU5I/iDi3b2T/OwEaGgxuLu920fVkyUHAFwicS+5UB1
         Q2Q6vBwyCzF5ClvD93lUXJLtyOwHqUCIzwgLy61c4i0Pi9feOnup3qn5qpDyNBpbASj4
         7dRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20251104.gappssmtp.com; s=20251104; t=1783934089; x=1784538889; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7gzkUPb1I6tE3E463cEtpSwu2IGZOQU1xcbEhICObCk=;
        b=U98dc7IviaCXGHbrR4UCs6Cqeui9lN/wwgXzoO1uWu5CmT7M+mbGqJVKNias0iib1R
         s4569Z79NpMQdIfhylKev1liMLBEYtfiz7OsB/Hpp7e9Zsme2AVzILxpbH70qGr2y5db
         u3yCy+8qm9arwxFppGfJsYO6KdwQENQ+EKA+LTEG9RzsvsEB/yc0nQhRJZweT7wFQjfF
         1vbly5EZjLgAjjCf7azPtciPRdqNIc6VxM80dStG4uZCWcjChd47GvBIsBHXzbhn8Lgm
         qHMss7dgHtw3IJrBC3+66ApuOFs2JfSSRnhv66EddmIqXaoZUQKUh3ylO5cRWOVodr9k
         NhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783934089; x=1784538889;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7gzkUPb1I6tE3E463cEtpSwu2IGZOQU1xcbEhICObCk=;
        b=EeI3QZLUcvRrK0Adc3wAoDpiZimXmUuIVR0ok5hPFqwZdWSACoJc52mBQFswsIHpuv
         51yFAUXuZDp475RCPSYdwDDpO0XJICsoG0mghl7Uw8M0i3a4F8eU268DwQa5VlLEpRGH
         uGPzG47sZWsVf9qwUwVIzA29gNFFkHrnmlcna/mAeje/0niqZ6XNzlo0QmguOFgLpwdi
         vBl3q/GU0xvXGXZYunh0RQkStjVyA2ZgNWv3Fr3SIax37NCQxCApn5MJ0DzXnNicW2Ca
         f621LK5SYHfdkENMbrm++FXf1giMJyi62yiI5JU/QWhIPaCb8GgyS5TOB+78THV4eQzY
         usgQ==
X-Gm-Message-State: AOJu0Yx4gD25E32KUQDFRa08aKb7nD6S1Gc5/eEnlcRywMUipEK3KyrA
	3aUBbOTOSYh6BH4Hz7JyYSdwq5Do+64qtW1LMnoLLI8K/Cbm2R1sTXq5NOisSiCjRf/DBhBSUiF
	o+0RCQzegDwNZuWaSrGmfEt3oXEwRUB3KApC+ZPYHRyv7Wcj9oPYSGvw=
X-Gm-Gg: AfdE7ckFOh4Q1n5HpXWl/g1xBrkVArav1siGdEB8NWN8WK9tRUTbccvlOFq1G3j9NGc
	QyuK0EycWF9Bu5ph4CT4hhIz6zQpa4x34tW/fSxMxBLSEYFjt7fJlRFw65IxSyEZ0iBz6le3Ps0
	pg5tbKbY42Am7RaQbB5tU4BSH90TDw0yCbzvgrreTf+RxbOSO8UU5fruT7FndEKh6HDTU0ouExe
	CsZbp/ZCODnWCPT9sjkmR2YWBCJKkipyJI1lDsT9NcAp/wtvbRZoZeD9UDaWez7PFpCYaxGXtJL
	ilptq68c
X-Received: by 2002:a05:6402:11d1:b0:698:9be1:4a48 with SMTP id
 4fb4d7f45d1cf-69c5f257ec4mr3287927a12.33.1783934088640; Mon, 13 Jul 2026
 02:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Erik Jensen <erikjensen@rkjnsn.net>
Date: Mon, 13 Jul 2026 02:14:37 -0700
X-Gm-Features: AUfX_mzFP3gQKcbmhBMy7-zNjP58RsbcbqhKx84qhBlQ8S1HQf3sdRO7w6pfuME
Message-ID: <CAMj6ewPbSgK6VnW91OG14Var4pBbeaZ5_+02znScvdk47Cm+Rg@mail.gmail.com>
Subject: Drives sometimes come up at wrong speeds / how to force COMRESET
To: linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have three drives connected to an ASM1164 Serial ATA AHCI
Controller. Due to whatever quirk of the initial link training, often
at least one of the drives will come up at a lower speed than it
should. E.g., maybe the first drive will come up at 1.5 Gbps, or the
third drive at 3.0 Gbps. When they do all come up at 6.0 Gbps they are
absolutely rock solid (many terabytes of data over multiple days with
nary a hiccup).

My current workaround is to echo the PCI ID to
/sys/bus/pci/drivers/ahci/unbind and then
/sys/bus/pci/drivers/ahci/bind. The trouble is that since more often
than not, at least one of the drives comes up slow, it can take
several attempts before all of the drives are up at 6.0 Gbps.

Is there a way that I missed to force a COMRESET on just a single
drive to get it up to speed without risking knocking down the others
that are already correct? If not, is a sysfs entry to do so something
that could be accepted? (Perhaps /sys/class/ata_link/linkX/force_reset
or /sys/class/scsi_host/hostY/force_reset or similar.)

Thanks!
