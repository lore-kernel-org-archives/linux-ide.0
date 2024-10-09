Received: from smtp-mibc-fr-10-azure-outgoing-2.mailinblack.com (smtp-mibc-fr-10-azure-outgoing-2.mailinblack.com [185.209.208.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB29154BEE
	for <linux-ide@vger.kernel.org>; Wed,  9 Oct 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.208.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457609; cv=none; b=HFH+oW0m+i96iIG1qAaHqbI6FH1cZGP974yP3cUf1wVF6mQbhtNR1/WNOAdA8ywoF/GliUXJDdlFHslLWnLuffdpmL06fJ2TDp620oorwYF8w9JbiSrzoR6Ag/Vmu4RioFtLzGS36OdHOPElx1Jwwqxfz/7ePlbE8wcJ/PGH6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457609; c=relaxed/simple;
	bh=N5xy07x0pO6OKXEW+GRqzcT4cGFZOKoEsUQAh+QNajI=;
	h=Content-Type:MIME-Version:Subject:To:From:Date:Message-ID; b=o8tolMv4DxrWUes0EgdfRfUGvirH0zL4NwCc2kfC1fnBO5xLnKbTDhQlAAThIah8CVzC3l4JUTFUvzqWhK/dI95j6aAj9dX7rKqD/aeRoJPI0WVueXgoOUCzAJxqEZD1q/jHACLZAmFboZLadmrAlF6gx344kKQNNPXoBIA2pVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sopadep.pf; spf=pass smtp.mailfrom=sopadep.pf; dkim=pass (2048-bit key) header.d=sopadep.pf header.i=@sopadep.pf header.b=L7QHx1Y2; arc=none smtp.client-ip=185.209.208.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sopadep.pf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sopadep.pf
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sopadep.pf header.i=@sopadep.pf header.b="L7QHx1Y2"
Received: from SRV-EXCH.sopadep.pf (45.248.3.202.ll.sta.mana.pf [202.3.248.45])
	by mx-3-mibc-fr-10.mailinblack.com (Postfix) with ESMTPS id 0A4E1E006D
	for <linux-ide@vger.kernel.org>; Wed,  9 Oct 2024 08:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; d=sopadep.pf; s=webmail; c=relaxed/relaxed;
	t=1728447855; h=from:subject:to:date:message-id;
	bh=N5xy07x0pO6OKXEW+GRqzcT4cGFZOKoEsUQAh+QNajI=;
	b=L7QHx1Y2ileysGDonOnJK301zepjjjwWHVzy/I3Xvw2vKatcB6SgJ7EeS84dtO4QpVVNAiIctBn
	do6d+e2Jle9/Y8RxuxM6fVVub+Frl3M2wgyK0JzPrZYAGtl6NtQcYJ+vGdoKuJSljpTwXT1v4sNcZ
	+94c1TBHRyqdKXVS4fMQSVxnrPVHZxXFreSStkrUM3tjN5z1QSpbxcK7zdZOKSEy5Zm2EH42Uag0o
	PgvwuCoRlXpSyWjt/sjXkgiQeE5F2/XGYmTDTDl7RGqjjDariPzIZEiS4rJoKCrhTdzLZh/S+Sool
	cs80ZBAAFzGxwmgnvrD3nJCQwlGwGuQzAUGQ==
Received: from SRV-EXCH.sopadep.pf (192.168.253.10) by SRV-EXCH.sopadep.pf
 (192.168.253.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 8 Oct
 2024 18:24:15 -1000
Received: from [172.81.131.214] (172.81.131.214) by SRV-EXCH.sopadep.pf
 (192.168.253.10) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 8 Oct 2024 18:24:14 -1000
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Aw: SPende
To: <linux-ide@vger.kernel.org>
From: <dir@sopadep.pf>
Date: Tue, 8 Oct 2024 21:24:15 -0700
Reply-To: <info@klattenfoundation.online>
Message-ID: <e52bb4d4-274c-4e81-96d8-e238ad79d8eb@SRV-EXCH.sopadep.pf>

Ich bin Frau Susanne Klatten. Sie wurden f=FCr eine Spende ausgew=E4hlt.

Susanne Hanna Ursula Klatten
info@klattenfoundation.online

