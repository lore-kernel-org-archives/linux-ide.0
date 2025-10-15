Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F92517AA
	for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551825; cv=none; b=hsmKEXnrKXNw7Bhew271Qag18StuI+AkEYQmzYd7nW9LWc+lBc1JHzmVL70DYpSG4o3VDwa0YAh9jVvEpQZsPXkT/tE9Tg/DQRQ01IJ28CukbsZ215Y/6EtCdfSLr/FqFAO5P1dXtjjm9y5gQnBF8RNaFYfvaSeEq2ijafJPv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551825; c=relaxed/simple;
	bh=PtB8HX542DQpCKnfLvm8bCI2d/dh1tlMg349uQtEJmI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=qL+jOcBmMaK6FrGhzZ8w/bvd2Uo96V60slP1PPn4gLgkp9lBYxZZ3arCIeco4f0p+1Yu0DoxZvIK7ZWQ7mDTdYNCIKUXIdsyak6rC3yIDH5CFylEx1lzEuwLYycutJQYr77S/6J3euWuk9dz23A2udhdJEkbvqPej7ykoIGkNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=mC520A1X; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="mC520A1X"
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1760551814; x=1761851814;
	bh=f5m/p7fK/LVBm+8cKonmLD5iUZPN2P/9b30dMSkqvw8=; h=From;
	b=mC520A1XG0C+ZMbWWi/loygAkf6i2UtE67K5pSq0p9nmyW+YLabztcCR95C5ywDhP
	 iADAwXEWlfzve9DRlejHLeueoFj75Nm5qOX0WqoBVH1APLeRMQ72H1e7/rgYzZ4kYn
	 gvDiN6IQle5FE/D62c/HnLKDDY1EcviJhJoZsxDCec+29txTZHA1cviqU9JDyAls1X
	 Um+eQTscALRl5/3iP0vFXnZdcu9TEF0kbL0Qn1mHEHHvyDgTb2k5A0YVU5EeJ1zes1
	 Omt86cWAiaqrivlsHj+dGsqQmqh8mBXCUNudIEp+WBQcumjvi5c/EBw6ZA1ZCsLZvj
	 OJr27ldgv57Gg==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 59FIADeJ053584
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 20:10:14 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 20:10:13 +0200
Message-Id: <DDJ3J5M82DIT.1WY8E1ZYTZTCT@matfyz.cz>
Cc: <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
Subject: Re: invalid log directory version error
To: "Niklas Cassel" <cassel@kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
References: <DDJ38NYG2CVM.1DZTADYTDITT8@matfyz.cz> <aO_hG8FYhWA_7mAT@ryzen>
In-Reply-To: <aO_hG8FYhWA_7mAT@ryzen>

Niklas Cassel, 2025-10-15T19:59:55+02:00:
> Hello Karel,
>
> On Wed, Oct 15, 2025 at 07:56:31PM +0200, Karel Balej wrote:
>> Hello,
>>=20
>> ever since updating to kernel v6.17, I have been getting
>>=20
>> 	ata2.00: Invalid log directory version 0x0000
>>=20
>> errors (one upon every boot).
>>=20
>> I have not bisected the issue but it seems that the guilty ata_dev_err()
>> call was introduced in 6d4405b16d37 and by the looks of that it is more
>> likely just an uncovering of an existing issue rather than a new
>> problem.
>>=20
>> I have not been seeing any functional regressions (which along with the
>> above is why I'm not marking this as a regression) but error is an error
>> so I'm wondering whether there is anything to fix (or maybe just tone
>> down the log level?).
>>=20
>> Please let me know, I can also test patches and if necessary, try to
>> perform the bisect.
>
> There is a fix queued up for this already:
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?=
h=3Dfor-6.18-fixes&id=3D12d724f2852d094d68dccaf5101e0ef89a971cde
>
> Will most likely be included in v6.18-rc2.

Ah, excellent, thank you!

Best regards,
K. B.
