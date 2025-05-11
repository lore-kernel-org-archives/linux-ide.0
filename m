Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3274D27E
	for <linux-ide@vger.kernel.org>; Sun, 11 May 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746989993; cv=none; b=VXqHPL5opiFv899uWW5ON+1Zb/jif2LggqtcJo3KNFIvWnYumLOgmSqTGezhMIZw1HCt7oy17Q31xfJs/ukXyZYk1CkGmpw7VvkpaIYzvH++0bgB7anGnRYdJf0VjT8ZNX/t1CShn4EgGofcvH6idEDxFkcWhqf4iuGgpUKQ2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746989993; c=relaxed/simple;
	bh=ztbsp//ebK/tMpFQ7VkkMsdZAr1IuY6Xz3dTlY6j/2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5MopyswGhducMU0LRFWXjfBaO5cHY0BnC1nKfTlsVWgVMR6Zd6+n6ucGk9ii7mzjFag5IjmOnKq3bjz5+5bWivMKD+GmoSsOFD5bbheOM6qLJveTGl37KS57V1L9Q7P7mJgmd2b3cQweWOUkqCuy079N/n2Is3Upc74rcg9+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgC/hzdJ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgC/hzdJ"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e6e1cd3f1c5so2905598276.0
        for <linux-ide@vger.kernel.org>; Sun, 11 May 2025 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746989988; x=1747594788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ztbsp//ebK/tMpFQ7VkkMsdZAr1IuY6Xz3dTlY6j/2M=;
        b=IgC/hzdJ1uL/O//V+znZRVLAJg5Qx4MYwOuEgKbw5Wp6J9kfSD5gr5vC21Gvk1OELT
         fY98DbNBYE5iiooNUOcCB4CVqfhm+w5Y6SVh4i3HEvLwJbtUJsKHypGoiWkLJ9bKscgm
         1yJ//2u5NvKwCugTd0kv0zGYR4sT/ZQu0JuShAqT7V5hFYzDxLGeX3qA3WPYcv/IGHVH
         df7Y8vI+a/hF3Qoki06ZWtG+ztouarPCbumOwt66kjzQkGQ86E0xffNDEQcEpEpXwrev
         jUxTiwqC8FUByO/WZRnKy6MSA0Bxi6JLTz1dlTD0HSUYxkz5+bueib3vBI2zvNyN/uZK
         Wi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746989988; x=1747594788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztbsp//ebK/tMpFQ7VkkMsdZAr1IuY6Xz3dTlY6j/2M=;
        b=IUmFitMxzMlhnhoAX+0ABEutSm7Wg9BzoHaVDV9Fei8Qd5Jx0sH0pM9dsL9+V9IHa5
         DOwUANPVb3X+VnjK9uvIRzJZ6IVd+ZDHUVzPoTw4Qz3l3ssV0Uqoq98M1xAQuiVlo1bg
         vWOqdYeC23ShPgWNFtqdwunYfg18Axu3y7Nq6+atwB9VOyWGIp79iYs9SlJh1Ur5F1vi
         PlJ/AUEeZ4x9E1mRrQaWqN8lU4Ouu87w4S9p9/SIn+TsTm7Zp6SxZKbEEn2168fQTw/y
         aQRkqneMFuewzKG7OPF5UpzgX2Gg6qrZPRWG6IyphAvmhYJZNB7kfGGPIDVdSw7uNRfK
         /erw==
X-Forwarded-Encrypted: i=1; AJvYcCWPHXVrj7wYyoCW5eDOS729lX7JvrRVRcs8orFyyR+3G2ZvkbrZ/vS+MUuxVaXK6v29sVFSSIqttBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMlUFWLBBXyk5C5J5fm8l+ep6NS3OI5yKbGOBSahPE3JVz5PMW
	fKGUz1pdoyar2hJHWHviOP9v9UGF6+6srQ5trTsO+z5MmZgnb5IcqFVTMOiLYg1N2cOUGkSk87L
	Knf8w5AEJCk7vD9wtUk00/SGfBq0=
X-Gm-Gg: ASbGncsmiqLawqFQNTJeMT7wfljv4jDTfuJrI5AM2T0Vr2zbTo2aTY6yepu4swpvxYn
	Fj7vg3E387Ne8irxCuK8dr2/AAtiQ6WHWckhe7NWiAl/Nvq1biNnv97CZZ+5J609J84sCWGKaNF
	awllTQIWVhRng9XotwLpYj/pkY7FXzdwuZ1Q==
X-Google-Smtp-Source: AGHT+IGVwRHgz684j5knWWUHLhcfkLIs6zcPyVk15/H2rt0TqYxLCd/3OmWFrFQ7tVmR6ddZxriNVsqlZc5T5K3/2Q0=
X-Received: by 2002:a05:6902:a85:b0:e70:ab57:45b8 with SMTP id
 3f1490d57ef6-e78fdc2b94fmr15578506276.15.1746989988479; Sun, 11 May 2025
 11:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
 <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org> <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
 <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com>
 <aBjbSt5hTaUP_JhG@ryzen> <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
 <f572f7d2-7b14-476e-aab2-bf674811dee5@kernel.org> <CAAZ0mTf3T5RTDKtd148GyGOiVz98isFFbMDXfku8yAk9FfLVeQ@mail.gmail.com>
 <aB8_rITWsMzkTiyE@ryzen> <CAAZ0mTe7Tpf2F1cKbmr==43pXDUxcPP4Q2AydpyDFJUrFHzNHQ@mail.gmail.com>
 <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org>
In-Reply-To: <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Sun, 11 May 2025 21:59:12 +0300
X-Gm-Features: AX0GCFs3pCmPFDbS8MmEme1U8b4YHcyfvpWdBLBFt7o77hTYW5qmkJJ6CveUTgM
Message-ID: <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org, 
	Niklas Cassel <Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"

su 11.5.2025 klo 21.53 Niklas Cassel (cassel@kernel.org) kirjoitti:
> >linux-6.14.5/.config:CONFIG_SATA_MOBILE_LPM_POLICY=3 (good)
> >linux-6.8.12/.config:CONFIG_SATA_MOBILE_LPM_POLICY=3 (bad)

Oops got this mixed up, my bad! I meant:
linux-6.8.12/.config:CONFIG_SATA_MOBILE_LPM_POLICY=3 (god)
linux-6.14.5/.config:CONFIG_SATA_MOBILE_LPM_POLICY=3 (bad)

Regards,
Mikko
