Received: from manage.vyzra.com (unknown [104.128.60.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2765331A63
	for <linux-ide@vger.kernel.org>; Fri, 17 Oct 2025 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.128.60.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706309; cv=none; b=i/EqiSXjvr/nm2hjQ+NnrQa7ieLwog5n2UmLW8pl18ip/MQW4dPdp92cVENiePNjwFwPiJQehevrsFW02PLz3Pr8F0WPaGKfYR1pHQvU/xmP8w5hCg2u1lSTIK/nrIVA5z0TSqnSoBHzVBGpXa8rpSgdH2lp25cK+iVQVdnKQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706309; c=relaxed/simple;
	bh=biLnUx9jTTyVdIbdiavoTAgEZeIqqOihfb373MH/e18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vE2SxT7oqopdgfPkK9dXIv+wJ9oIBSAwpn0jCt9PWm8VuBzX93hsOXGhjtDnf6KHbhmOYG4gmMVKm8sRZTOQleeD/oLxXR+Hv8MdQ8wUPoPE5NRyKUUf0fl30N7L5reyl9cb+T/1X6dkQv7WsogWtbg4iDWqPOnf0VTo26rb0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org; spf=none smtp.mailfrom=manage.vyzra.com; dkim=fail (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b=vQUHXS5F reason="key not found in DNS"; arc=none smtp.client-ip=104.128.60.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=manage.vyzra.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b="vQUHXS5F"
Received: from debtmanager.org (unknown [103.237.86.103])
	by manage.vyzra.com (Postfix) with ESMTPA id CA5054AA31D3
	for <linux-ide@vger.kernel.org>; Fri, 17 Oct 2025 07:45:32 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debtmanager.org;
	s=DKIM2021; t=1760705133; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Aj8bDacQlJB5qNMC5+yWWged1+K/M8YReXQkzUminbQ=;
	b=vQUHXS5FD15Yje1Z0oEPP8c7uoxAnyiedHKUuSGuaAkNInYNwCRs4dhe2sdaI/3C04zbEf
	eHk7CYprk6DdwloIJVdjSBXD/aV9S0z/UIoacXP2FvefndXiNv1LKu+46VPMwl9H3ZXVon
	jfoer7XKGjT2EPZiqhyV74dm/J1kCjQToSta3hCXsqTbIaPZSwuJlYOfhPvQ9wpij+7mpU
	o6kq96lBBFWchocBUk7ou1tNydSW/EX4+cZIFzZSThNFsXFCrndZk78ryeGmiGun6RLyY2
	EMEFYopVVbIJqGpz4tKLa3ydWWvw1BaBYFIJZs/wY+/hCxXEC6CFxLqU9TakkQ==
Reply-To: vlad.dinu@rdslink.ro
From: "Vlad Dinu" <info@debtmanager.org>
To: linux-ide@vger.kernel.org
Subject: *** Urgent Change ***
Date: 17 Oct 2025 05:45:32 -0700
Message-ID: <20251017054532.5E0E11A4D63AC48D@debtmanager.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.10

Hello,

I am Vlad Dinu, the newly appointed Director of IMF Legal=20
Affairs, Security and Investigation. I have been given the=20
responsibility to look into all the payments that are still=20
pending and owed to fund beneficiaries / scam victims worldwide.

This action was taken because there have been issues with some=20
banks not being able to send or release money to the correct=20
beneficiary accounts. We have found out that some directors in=20
different organizations are moving pending funds to their own=20
chosen accounts instead of where they should go.

During my investigation, I discovered that an account was=20
reported to redirect your funds to a bank in Sweden.
The details of that account are provided below. I would like you=20
to confirm if you are aware of this new information, as we are=20
now planning to send the payment to the account mentioned.

NAME OF BENEFICIARY: ERIK KASPERSSON
BANK NAME: SWEDBANK AB
ADDRESS: REPSLAGAREGATAN 23A, 582 22 LINK=C3=96PING, SWEDEN
SWIFT CODE: SWEDSESS
ACCOUNT NUMBER: 84806-31282205


A payment instruction has been issued by the Department of=20
Treasury for an immediate release of your payment to the bank=20
account above without further prejudice. We cannot approve or=20
schedule payment to the 

given bank account without your confirmation. May we proceed with=20
the transfer to the Beneficiary: Erik Kaspersson, bank account in=20
Sweden?

I await your urgent response.

Mr. Vlad Dinu.
