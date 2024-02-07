Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62B12E5D
	for <linux-ide@vger.kernel.org>; Wed,  7 Feb 2024 04:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707280260; cv=none; b=dzwQ69CXk/ksJqkIIU5YpQYrEfDIkOQ8aRoWALReK5cPvHal+9Ei1QUnkL2jmeYlWpNqhhBD11CrSM4CDd05IJS9tgOOml2RGIFyg8/M1p4EDEz9qznyOzOOEmo71ZVk6jXPtK1cjt+LUBUrUg2DDEPoaBr6+emBcC5u+lTNf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707280260; c=relaxed/simple;
	bh=pF9LJklxfI2apscldSm1xq9nHGtdRfxPuJGaTb+lXpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdIy6TR/KiYCZGx9SYvOKaBneL0I+F19SN+5y7VJrkii1RCDXRxuHDG0QTAeatQjZcaPxooIvhe4NlyxlHaYaTX9k6xn15iqJnhro59abVPz5Hcq8XUpMTj9RWd+tojGIuHOgN5ZR99XGqA/jy2uSs58pXE5kR4aDLkwQqV5jbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=dvmtiTlP; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="dvmtiTlP"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6db13f1abso181672276.2
        for <linux-ide@vger.kernel.org>; Tue, 06 Feb 2024 20:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707280257; x=1707885057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYWFihu0EI2E5w/29EHsoSMc6REcuixgJW7yq5U1pxw=;
        b=dvmtiTlPEh9axSBMWsWWfz0jIseI+wFHWvIOfYc9YYU5+GNt8U8uV4EWfX8JOCCVLJ
         Tf0IRZNwtqjrplGg21fjNvOggzhsB3k1VQyCHuqyN+m7TALtd7IT9AZaQp5BbydB+plN
         ANkRVGvJM5azkwCUvXvQ2FHmnF/pu87tVJOam594d7SGyH60jyXf4dl3r5DNl4oJ01Ck
         hlAQ2RG/5PCVFnqmE7XtPX22NX0ZS8HOKr47qZqFTAy5jL/e1FZQEnkY9oNtWqPViWeF
         7RYYPvNFEzhvPKVntVPrYbaZ3KHJysgFt3vUbHCKwbgTh247FePpPEW7GeOyLgarwsXV
         8a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707280257; x=1707885057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYWFihu0EI2E5w/29EHsoSMc6REcuixgJW7yq5U1pxw=;
        b=Wd/St1Bbf+xrei+YS1g7+GN19s/iX9ZMo9eUhgi1ED5XEYgubz7s2FVhg7ZNIDVJGI
         oGhg7b1Hin6pLfd/8upWPN5WqxmeAanEIGPrvvCYKmrE/UBWL1pILf1adQ/dFXtPf54V
         5gpG0G3wB5jILTYYwTTEQFsue3rQ91x1Vk2owkhkVaNqajUt8loGuJwgzJLcJVo8uUE6
         ViZhFlM9ppuM2YuL9ZDt0eSZiMpXhZ5oeu2e2RpGAhb/bhtXGzUPl4Vm7XWmhdi9b9iW
         SwcFbsa0/ZCPtDsEq9k7fzKyc0QwdzUU+YONCdLsCWGcHgatKrIrQAyHG5VQpWGT2ewH
         xL3g==
X-Gm-Message-State: AOJu0YzNfB+LB6tBU/d5Gf7wzF7mk5drmqFfcwTz1IL9FIdo01CvmTbA
	TNv5+/t91r6fca9fAT/TMYZ5zdUy55f+iMmc31Zirj6z783oN3+RzDF4TCUVxU+sLjlzknWdExg
	YVBbTw4sP37kPRdxMNGXb7X3hPYhWDVrtlUTffw==
X-Google-Smtp-Source: AGHT+IEClkn6D1RiNIG/8s70T/P5zAp7+nm6M9CO7SwGr8f0xX6byJe7I+xj11wLyb3WyqriN8fOUapsLnfUZ+fPkPo=
X-Received: by 2002:a25:ae27:0:b0:dc2:67d5:f28f with SMTP id
 a39-20020a25ae27000000b00dc267d5f28fmr3133380ybj.43.1707280257380; Tue, 06
 Feb 2024 20:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206211352.1664816-1-cassel@kernel.org> <6bf9d981-5dd5-4f74-af8d-e8eb637d569d@amd.com>
In-Reply-To: <6bf9d981-5dd5-4f74-af8d-e8eb637d569d@amd.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Feb 2024 12:30:21 +0800
Message-ID: <CAPpJ_eeREdf90JD1H4GtmACgLembW_ZbJB1AgPZoG6smnxF1kw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drop low power policy board type
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Dieter Mummenschanz <dmummenschanz@web.de>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mario Limonciello <mario.limonciello@amd.com> =E6=96=BC 2024=E5=B9=B42=E6=
=9C=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:54=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On 2/6/2024 15:13, Niklas Cassel wrote:
> > The series is based on top of:
> > https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=
=3Dfor-next
> >
> >
> > Hello all,
> >
> > This revives a patch sent out almost two years ago from Mario Limonciel=
lo:
> > https://lore.kernel.org/linux-ide/20220524170508.563-1-mario.limonciell=
o@amd.com/T/#u
> >
> > The reason why we did not merge it back then, is because LPM and hotplu=
g
> > events are mutually exclusive.
> >
> > The difference with this series compared to what was sent out back then=
:
> > I've added a patch that checks if the port is external, i.e. either
> > hotplug capable or eSATA. For external ports, we never enable LPM, as
> > that will break hotplug.
> >
> > For ports that do not advertise themselves as external (typically lapto=
ps),
> > we set the LPM policy as requested.
> >
> > This matches how Microsoft Windows does things, see:
> > https://studylib.net/doc/10034428/esata---microsoft-center
> >
> > Thanks to Werner Fischer for suggesting something like this at last yea=
r's
> > ALPSS conference.
> >
> > There might of course be some platform firmware that e.g. incorrectly m=
arks
> > its port as internal, even though it is external, but if we find any su=
ch
> > platforms we will need to deal with them using quirks.
> >
> >
> > Also note that we even if the user requested a certain policy, there is
> > no guarantee that he will get all the features for that policy, see:
> > https://github.com/torvalds/linux/blob/master/drivers/ata/libata-sata.c=
#L403-L414
> >
> > However, I'd rather we not try to map all the combinations of
> > partial/slumber/devsleep in to a single policy represented by a single
> > integer, thus I do not try to "change" the requested policy.
> > The user will get all the features that are included in the requested
> > policy AND supported by the HBA.
> >
> > Another difference (compared to an earlier version of Mario's series)
> > is that we do not try to change the default CONFIG_SATA_MOBILE_LPM_POLI=
CY
> > value from 0 to 3, it will continue to be 0.
> > If you really don't want LPM even if your HBA supports it, and your por=
t
> > is internal, one option is to leave the Kconfig set to the default valu=
e.
> >
> > Damien: considering that the Intel VMD + ahci_intel_pcs_quirk() bug tur=
ned
> > out to have nothing to do with LPM, it was simply the fact that the
> > ahci_intel_pcs_quirk() was only applied if there was an explicit entry =
in
> > ahci_pci_tbl. So since that bug is totally unrelated to LPM, I no longe=
r
> > think that this series need to wait for a fix for that bug.
> >
> >
> > Link to v1:
> > https://lore.kernel.org/linux-ide/20240201161507.1147521-1-cassel@kerne=
l.org/
> >
> > Changes since v1:
> > -Picked up tags from Damien.
> > -Moved the comment in front of ahci_mark_external_port() to inside the
> >   function.
> > -Modified the comment in patch 4/5 to more clearly state hotplug remova=
l
> >   events.
> > -Rewrote the commit message for patch 4/5 to be more detailed.
> >
> >
>
> For the series:
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
> > Kind regards,
> > Niklas
> >
> >
> > Mario Limonciello (1):
> >    ata: ahci: Drop low power policy board type
> >
> > Niklas Cassel (4):
> >    ata: ahci: move marking of external port earlier
> >    ata: ahci: a hotplug capable port is an external port
> >    ata: ahci: drop hpriv param from ahci_update_initial_lpm_policy()
> >    ata: ahci: do not enable LPM on external ports
> >
> >   drivers/ata/Kconfig   |   5 +-
> >   drivers/ata/ahci.c    | 135 +++++++++++++++++++++++------------------=
-
> >   drivers/ata/ahci.h    |   9 +--
> >   drivers/ata/libahci.c |   7 ---
> >   4 files changed, 78 insertions(+), 78 deletions(-)
> >
>

I have tested this patch series on ASUS B1400CEAE with both enabled
and disabled VMD.
The SATA storage works and binds the LPM policy correctly.

Tested-by: Jian-Hong Pan <jhp@endlessos.org>
