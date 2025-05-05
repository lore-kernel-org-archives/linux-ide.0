Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA661DA31F
	for <linux-ide@vger.kernel.org>; Mon,  5 May 2025 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473943; cv=none; b=J/AC7T7Wtk8Tpo9aXbjcfPjzd6iWKw4I4XslYqEu87o1JFA2/jIsYJRkX0I8sPmWgcf4Ns+R3FVtk5B6qZeNCj7m9nMbqag2x3onHBZevFleujKdBSDNcac/IOm4tm8W7QpsOhFXNvx81pQymcxayAZ+7MbNT2ZpCtadqQVOUZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473943; c=relaxed/simple;
	bh=tczwK4AAfDPvvc9GGKprWsWG0m0jLRJKGXzqoR2sf2I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lKhygs1unYlfk16t/7GP+lwtYXjt584nzB1PWiVVzUDajkU7JZ7sZzNgOGT9SrEyEWl1L+y4yuXDSOrn68IEpadDS9ROQbMUfMDFr6tMw6HeZJLCl6PiGA+22dz2VpeelYodjzuLau+/Ragu+v4A6qFPUObHllzTMMAHOgg07TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdT54OFP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdT54OFP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224191d92e4so55334465ad.3
        for <linux-ide@vger.kernel.org>; Mon, 05 May 2025 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746473941; x=1747078741; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tczwK4AAfDPvvc9GGKprWsWG0m0jLRJKGXzqoR2sf2I=;
        b=LdT54OFPz2LBn4U7eG4Iea8lBJx6W7UvrvDAPaY3SHwPdJ4rAwtRwqzihapngeUBJt
         A0dfAnfGSkKKgrW8QpW6M5nKAE5mfKXmMwxvuJ6FrMHnFBdkczCXZ76Fd9FVtaNNztqW
         fA1+/dflBOJSM4jmQh+oWlwTKGo9QV4ierD9vdIcwNZMkl6jsuNm9zi8bbBQpWSeLe6u
         LrMU5LmMO/pa2aJBzgt2yVO6nm1z2mYdJme5MvXyAadceYXpfmOIBosV9EMUngMPzPiU
         WsorQ0U1q6Y24H9luJCogCrUYvo0lrucMvTOxZWSJCNX49Inm2juj2SeRnfowWKEDqiS
         3sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746473941; x=1747078741;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tczwK4AAfDPvvc9GGKprWsWG0m0jLRJKGXzqoR2sf2I=;
        b=uCajPGoNAejSeDIbri4XVKGh8lyEQqEjpFXtXc/iou5g1UKtdpRxsvKujoS2h1dAjS
         L6eWPXrafmTlcTsQD9WjwuM2tOuodwNxqbm2zJF1StN76ob+RFPOBYjyCeh4o6zLUzFK
         6gjCbxJOvcsvUwp7hDlNHj+vLFPYlwnJHT5VzTpGGk93rbx1T1ndsqfR9b7hq9yNIUyY
         XD9FDghSW6yqFjQH3ZEj6pdBmmQpsPWn9juSGRU/ZRVutrYSwF/K8Web0NG+gIE4a6D+
         Xrypn888qZK9Eg2FGXFCpRMLYDNDxvLYccCnUGCpYMcgpFc9NElAJgq2xr3ZPPYKotmq
         vmWw==
X-Gm-Message-State: AOJu0Yw9OnM3vWlHJU9LZP1o5AJ7RFIQfvt+q2NcBHOF0rKqfPvF7T/P
	KBucjmWgkUSRPZa+8pB33NepHjrsumaDuDzGT6V7uG/ugUHu3qCtlx9AirvNnH/81XwQaShVOZN
	YiAOyjsmzgTYZLtSxu/Luwvhwbqoa1Hyetdo=
X-Gm-Gg: ASbGnctOdvgLHh1s9mIRct4Dcqf+2gxBY9TbJjTJYg9wbgzBcOL1ai4t4zu9WVkw+3i
	W0wtwNSdvS4kNzlEbSuW/ymaeQrLlGy5m56VvkbRATwfri5wtA5QKSdcFjPn0NT73bvYsDdp5s0
	9Pd2RqkK979vepW+1pymha8Qb6mqLAssO02xbiWVg2aymyUSxVkHAxcvaezAyVW2DPKg==
X-Google-Smtp-Source: AGHT+IH1cv9nHTzpuBleqj2tS/meOsTOqaJj/B0BivafDejxgP/SY8qFHaMpkjLNqKnSLypfAZ+MK7Pjol7URQJSFLs=
X-Received: by 2002:a17:902:ea0c:b0:224:2384:5b40 with SMTP id
 d9443c01a7336-22e32aa1e2bmr11069315ad.24.1746473941500; Mon, 05 May 2025
 12:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ioannis Barkas <jnyb.de@gmail.com>
Date: Mon, 5 May 2025 22:38:50 +0300
X-Gm-Features: ATxdqUEbJFUySsGW4AFEiFRCLy6sLX8YnD0iLhGaACcr_Rldx573tS3_9X-glZw
Message-ID: <CADUzMVaY_nv1tjFtSuuPiNE6=_h2LABaDAjuOhK=FUdDB-LsrQ@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Mikko, thanks for sharing all those details, we have some
additional information on this.

I am suspicious with hw and not with you. A quirk will affect lots of
devices and we need to be sure that we have examined the error you get
so that there is no need to revert things. FYI, I have a disk with a
quirk for no obvious reason on all hosts because nForce had NCQ
trouble with it. If a quirk gets applied usually it stays for a long
time if not forever.

Back to your case, on first look I can see that disks are in mint
condition and are running the default fw, 82.00A82. Damien is there a
newer version available?
Please run a short test to each one to ensure that everything is OK
after working for 10K+ hours and share their health log again. It is
clear that both go south at the same time so RAID array dies as
expected following that initial event. You just leave the PC on and
then you get that event on both?

Supposing you get no error at disks after all that but still disks go
offline, I would suggest to update your board fw to version 3621 and
retest. The controller-disk combo should work fine. Just to clarify
things, upon turning off LPM, you get no error at all?

Except the short form of lspci, let's get the fulll dump for SATA
controller to see its active PCI settings with:
sudo lspci -nnnnvvvvxxxxks 01:00.1

You can get it before touching anything and then with 3621 fw if you
update your board. This will pinpoint if anything has been modified
between different fw releases.

If the problem remains no matter what, a quirk is inevitable. Do we
wish to block LPM on Intel hosts while no one has reported errors? How
about a new quirk called ATA_QUIRK_NO_LPM_ON_AMD500 for 500 series ICs
or ATA_QUIRK_NO_LPM_ON_AMD similar to ATA_QUIRK_NO_LPM_ON_ATI blocking
LPM for ATI chips?

Best regards,
Ioannis
