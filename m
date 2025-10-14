Received: from mail.commetrax.com (mail.commetrax.com [141.95.18.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1427464F
	for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2025 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.18.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428881; cv=none; b=P4saPQhUirjLU3iD19u8YZxngDpeimWvo5j2W4/P4hD1UuUkYxHtaGI90HnolX7O4uXhUGPxHYowlgr24oyv5jlsOd+gem9btD8XSvOl7AKjY0kKXnBdq1aOADipkhSW0KskceKXjK7yqGDCKXhFk6PhyaH6uBSNyuoJ3nJKsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428881; c=relaxed/simple;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=L9zVg+UKAqDt1oF0SKTNUUlahxNHTzGy83RPXDvRX2p5jlnkMjGMF4VrxYsuGoLbjw6e6za8OnW1RXPGRmfoTAzoE1eXnSJVmE132ZfWgg1Y0rpSD78vZrtERpoG4rQyuErZvWgEdyQjl7sXnhUGZhSQ1ZZJdKzeBs6sHLpUtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com; spf=pass smtp.mailfrom=commetrax.com; dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b=BfIULRcb; arc=none smtp.client-ip=141.95.18.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commetrax.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b="BfIULRcb"
Received: by mail.commetrax.com (Postfix, from userid 1002)
	id 133EC24045; Tue, 14 Oct 2025 10:01:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
	s=mail; t=1760428878;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Date:From:To:Subject:From;
	b=BfIULRcbjJhFnvlJRlHwwqFy3ZmzgOYcck1rziLurhSQswLPp1usx00slKEzqHHsD
	 7BoALR7O3E6p54VwJFTzTxprFk7ItZPDJWCHI/nYfcL0v5JJmmfJ0gkuzLBt4xmCSc
	 nUerfMYbzW9t+wI4x/RQAnapDinS+lCLzHnF8ppYeiq1mW6hVNb7aAuRQJeBbDsZaw
	 i2hmI/j1RcK+WAm0g484Li6xo7eTzzsesjQuSbw2kNdhXZWw44fF3CPysEL3RX8Lf+
	 +LO1boMaQw+i8bO2kx0YyMKHWxlybNq2HKX+oE5SLp8HmiNdxbR3YHFJzwNywqyJyj
	 Kn19I2eMBxd+A==
Received: by mail.commetrax.com for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2025 08:01:13 GMT
Message-ID: <20251014084500-0.1.c9.16nwv.0.ne0hft07l0@commetrax.com>
Date: Tue, 14 Oct 2025 08:01:13 GMT
From: "Luke Walsh" <luke.walsh@commetrax.com>
To: <linux-ide@vger.kernel.org>
Subject: Welders ready to work
X-Mailer: mail.commetrax.com
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

we support companies in carrying out industrial projects by providing wel=
ding and assembly of steel structures =E2=80=93 both on-site and in-house=
=2E

In practice, this means we enter with a ready team of welders and fitters=
, take responsibility for preparing the components, their installation an=
d quality control.=20

The client receives a complete, safe and timely delivered structure.

If you have projects that require steel solutions, we would be happy to t=
alk about how we can take over this part of the work and relieve your tea=
m.

Would you be open to a short conversation?


Best regards
Luke Walsh
