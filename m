Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BAC4503F4
	for <linux-ide@vger.kernel.org>; Fri, 31 Jul 2026 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525131; cv=pass; b=QpVMw2ez1gQsAa67S2NIvccVlcpfNKpRr4FqHjQe6gJg6DX7yQVxNUStfJDNr52xADhLUJGG3gE6otsRu+Gf4uNeeM+dZIXdxsIwCNdsrg9SvB9d5Ct7GLkPBv4NBSeBRGLwhrzUww2Zu9fdMMiEaZPDMkhu/DT/q/Ox8aXFycI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525131; c=relaxed/simple;
	bh=fnAEEtOQRwyZBx8qZr0oVK0/MJ5m95HtZqcO4+SCbPU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aE+e7wnbKPoU4zr7ln6wMS0k651miEoAgsFlL1pq4nWbjg0/CstG8w1pgRXSPtXc+Irv48BpwI6k3bVjm9ohdYFqriDNXMtwpEDLJczWyo/sExjUICtwsGKHxyni2hb0Ba3un1Lv78F60hKX8M4OUVgXXmRDwgqm15VyyFo16mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+HZiIDN; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+HZiIDN"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15c42a45adso341367666b.0
        for <linux-ide@vger.kernel.org>; Fri, 31 Jul 2026 12:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785525128; cv=none;
        d=google.com; s=arc-20260327;
        b=Ea7Cw4jPn9jUjJ0ZHxGEl8KJUrum8Kcq65DNIlXy6Ry3NTaSRmlCMC/w0/ZRSUwxmF
         hzdtRRr5/3WIgU4Z88tv5D+HEOOJPoJdSxf3y+2I69ANnwWzTOFXO9bQ2lHZQnKbOLh9
         8+ER54Ur1wE6WRT3LLSyuwH5uraPunEfD25q0WXD4L7PDvDBFr9OqUYfcgM1Jz1v5+Jk
         TpEzSirxZB5HettRLhr+5ibY9dqfBz8njW2KLxvo/gFpfM8i0ySq0f4sQy1cajB1rd5d
         jIgPJ2Pa/MFIEIz6mtpx5ZObwpMhdI0YKMwMIpZNMihNVI103sA/Lv+u1h1OVaUF6L/W
         XXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kZ5kWd7p1yGkjjOxO2SfkaE8r2IEuORhgbo13qPYIS8=;
        fh=ztqLSSfhfzwf5R5ueAL3RXPewrpq9XyecaQfGUPz7Y4=;
        b=Kl3ZQmoOr6R2EM0SeUweSyD7OSr00pI4KTUI0QUDDxSv2QyGEwHgN2Thni1VNppDFw
         eF5BLe2CCZejXhjXvs8Y+evDPG8PeuOMhL/QMpakagjYkFEhogzZ2X3yZshcM+/QBEqx
         VijiVNwdLTtFts9m/cWyqptYlu1yy1HtoIhOXdOGYhYEpzq0yuneN3Xrgrk/3GEqk1io
         jckCcBwgescSM1aNxtj70YypE+FlcO2mjOqBVEvB1r7ps6uJ0l7Byxdza4rNxd8g059W
         brI6cW99I2xQL1QxzCFNy/jLnS8+KcoUbJLntr/xH247CsWdAnav0BFWg1tLPG7A7vPz
         OS7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785525128; x=1786129928; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kZ5kWd7p1yGkjjOxO2SfkaE8r2IEuORhgbo13qPYIS8=;
        b=G+HZiIDNhkXPEjoa8KKtp34CAzbRIWtqYolDPmYovQMoumsxf6TLLoIhypV2/JPu2a
         w57WXdZ69pHy3HpwPcCRe00FJp7N2e2U2H8yc1ZNPPwB20rgH2TFof+waf5YesbtJv95
         K67PVT+TbccvYzH9XQQoYNZ3Fr9iZDXD5c5ZoFTN7AkiGz3+mHCRLg9iw96HZIzLA9fj
         PDRHdzrQWw3Bzw7WVgBtzuEUPrFvuOKNS9ayd/0dqpLJWXUfZP6C94DGhgTTdsBVP4Tz
         kkvPjCopduySykGPRvTGKtGwi1w56hSQx2E4j2vEnchTHrnTGFtar5nHAR3C5SeN27m6
         Mq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525128; x=1786129928;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZ5kWd7p1yGkjjOxO2SfkaE8r2IEuORhgbo13qPYIS8=;
        b=Xc26748gJXlK0/DlHJgpfdZ+eCQI72CKg6OsE/7PKg0jWz8jqKF2rpsfoaODpDkTYY
         y7MkO4bUVP5iIZp2OuveMT5Qsn/Kq+UQFkL9YpJXBxNznwAMHF8swONfxvofgz8vM84a
         SLNbv3ytdSSzWu3fGCjWvelohoJjLUkZwymnu5RIajqY1/NZ2/DlAPdgul7ScVkIdYpa
         4OfdFJ7WKCdsDahvC6XoCYFjPcpoYP4vCo3weSzp+kHCPkWILwXqY3UDjN/cRy+KM6G6
         +mNJZqYfyNbzAGlxF5c6BwVavyFbR10c4g2RQSJbWv8Xo6/krPwh2mh02XGQfKdVEA+G
         5NYg==
X-Gm-Message-State: AOJu0YyxmQB53yjJqiZpiE9RXpHm56I23KdfiPq1F2LQK+Tl7fuYD4W1
	/zFtwqsRA+L2xBS1mIs3v8Efwiygiw3xWwQYrGvOEEHPtyg1js/AtT5+Lj1Z1TDtJMjufmbpjTR
	YPLYeNoDN1U/jRC/a3j0p58pRJPZQOh7DIhQ9cIk=
X-Gm-Gg: AR+sD10UCP/c8I/2LSn6YCbUaPJPadX/19+aRkRlYywW8Q8odr2u3dUgbjbgalxwenl
	5fV+QX48x+m8JqA5ptWiM3HLAY6rNAC7LnI5KjTQB0qRqCh30Ejk54zxH5a60YAjRtVfdE64+66
	NV/XC5PmrI8ROl3O7H+UYmNATf06pWpJwitN5AF4OpKi2w9Q3hHgHLoTaHBUDSmHR4JrdYWDyVY
	W4aQmFDWHaOw3RUO0Yv3TZx0XOxgajcu0jLuwzl+ydOWBcNkkpSjuTHSZRAuz9GxgHPI6RA4XlJ
	bZk1V+kr2oEjvL2YAviqs9Li+ToxCHQSN2lWAB0IuFcDcmT/yPCxeTWXRrfXiKQQj90KYf8tLAp
	Acury6SexHNSTSQdMoUMbITM2Xn0X9b39e//A/6tzuuED0Mh0T2I7fMz/yP12/wgSsaxlxb0cUp
	7vSIzp+O+nCovMKlwRUMM=
X-Received: by 2002:a17:907:9446:b0:c16:242a:4744 with SMTP id
 a640c23a62f3a-c1fe7bdaeedmr45464066b.17.1785525128141; Fri, 31 Jul 2026
 12:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hank Barta <hbarta@gmail.com>
Date: Fri, 31 Jul 2026 14:11:56 -0500
X-Gm-Features: AUfX_mw5e44I8RyVAlEho48wRuwx4oaWviD8MD-VENPUA_Tcd-XL2JGqG85xlLg
Message-ID: <CABTDG8-3oiR+P7ebTx2PY-OQNGoMod3CRSk9uMaTHKW4FnRKbA@mail.gmail.com>
Subject: "ata2.00: Enabling discard_zeroes_data" in dmesg 1/minute
To: linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Good afternoon,
This message is being posted to the kernel ring buffer 1/minute on one
of my servers. I just spent a few minutes with ChatGPT tracking this
down and ChatGPT has suggested that it may be due to a regression in
libata. Full details of the interaction can be viewed at
https://chatgpt.com/share/6a6cef79-9bac-83ea-86d6-5de28f09e70a

As near as I can tell, the message is harmless aside from flushing the
kernel rung buffer. Some brief details regarding this host:

Debian Trixie
Linux oak 6.12.96+deb13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.96-1
(2026-07-20) x86_64 GNU/Linux
ZFS version   zfs-kmod-2.3.2-2

I searched to see if this had already been reported and found nothing,
though that might reflect more WRT my search capabilities.

Is this something I should submit as a bug? If so, kernel bug list or Debian?

I appreciate instructions for how best to proceed if I can be of any
assistance. (And if that's "go away" I will take no offense.)

best,


-- 
Beautiful Sunny Winfield
