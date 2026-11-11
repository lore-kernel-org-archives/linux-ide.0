Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391985;
	b=uiHh+4d8Ksj5YRd1uK6Dsh8/DwFTu5i7UxoRrPelzxZnnDUhlmcdWmLs1M8gcrJgdMpI
	 jHnx+5ICl44KrOGIrnmjd0XiiwZVBSQbNl2da8UpD97FSTtnmoeejUg1y1TVnb01UAVzT
	 9WUzWAX+F92+cYTl5J39SD0+Ahi9QnRxnfZkvJiUCNT2dNmj5XE/DIx4lkZKJL6gcY82M
	 RNH9YyMh+sEtJ726lGZD29H76rT9YwIBhQMXtNfKK4beiIw/0qfH6iX5sTeYfcP33KFDx
	 OP+OFHrkBIL9RSyTmcL6gZVb1D9prVBPqasQD6kEpH41KaIqDEemOqPAkTFBQ2KI6NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391985;
	h=DMARC-Filter:DKIM-Signature:Cc:Date:X-Lms-Return-Path:References:To:
	 From:Mime-Version:X-Original-From:In-Reply-To:Subject:Message-Id:
	 User-Agent:Content-Transfer-Encoding:Content-Type;
	bh=xx6TPToq5gieTMY527jOsgu4eVMLRX54BNjyVA+AhfU=;
	b=admWtGfQIMInO8m2S8i4YVmQRe+0b8mZwbgdnJmN4h7dHxaQbg9nKuuV4rS11X+sUXzW
	 yEfEtJ6PpkffnA4vZh2sYTwfxm3/iUlRfP387BWqWzGN7ANZYB8XenJqrJYkfMIX+er7J
	 mXK4Qv7QrZ3+QzECotyJzBaTXn5URiX2XbPX4iMNNuIzfwtT/dwRnwPrybhkQQM7l9X2d
	 YvDs2rzuC9LQ2mI78HJ4i6YKeOYTRP45b0XL/Nj2K5MFJcIcayi5dOMnj1KIXbjxBZJMa
	 KN1WBMdxv/20qz78s0Hr6gR1BN1QaRKEedssz7t48tvPG8MxrOtz0SUL/NPcxBWBqag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b="k/SGM2Of";
	arc=none smtp.remote-ip=209.127.230.112
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF1606A326
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 10:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3EF1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=k/SGM2Of
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794391978; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=xx6TPToq5gieTMY527jOsgu4eVMLRX54BNjyVA+AhfU=;
 b=k/SGM2OfXOwtgFzZbyLLsdABlWr3aP1GRYR5K47cxbXdTSIcYSLOoqFGr9EgJN0NxR9+Ay
 SY/128MIzirNu7DfwU5PPbTzwPSB87W5I9TMqJ6K4k04VIl6CVulJ1trA9mjWaNQEinB2y
 AK+OZ+d+8ur08549GafFIou+oMmOF33XWDTwrttu2Gv6qR5jqN830aveDx3gD8grj6cNz2
 Nmm/cdvrDQZjiKFmuM2rRcLhK131vTpTut+uvaPhobpkjGRcC65cxfiP27INbpeOhUZtpF
 YE00RxNJQSwkV1gTbytqexz+EoMnq9imZbnV8UHCuu9DFdJyg9PwvF8Tr6u/fg==
Cc: <linux-ide@vger.kernel.org>
Date: Wed, 11 Nov 2026 18:12:42 +0800
X-Lms-Return-Path: <lba+26af43fa8+8cc7bc+vger.kernel.org+zhaogongyi@bytedance.com>
References: <20261028140432.20489-1-zhaogongyi@bytedance.com> <avLYvtmnedp5FXSX@ryzen> <425aaec6-89bf-4150-ab87-360cc30dc72a@kernel.org>
To: "Damien Le Moal" <dlemoal@kernel.org>, 
	"Niklas Cassel" <cassel@kernel.org>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
In-Reply-To: <425aaec6-89bf-4150-ab87-360cc30dc72a@kernel.org>
Subject: Re: [PATCH] ata: libata-scsi: reject non-PIO protocols for READ/WRITE MULTIPLE
Message-Id: <a3f60789-0266-4c35-894e-79753b7593ce@bytedance.com>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

Hi Niklas and Damien,

On 11/11/26 4:52 PM, Damien Le Moal wrote:
> 
> Unless we are talking about a command that libata-scsi emulates, passthrough
> commands should not be parsed. We do not want that. So unless the bad SG_IO
> command can crash the kernel, we should do nothing if the user sends a bad
> command and it fails. We can let the drive fail it, even if that leads to drive
> resets etc. As Niklas pointed out, SG_IO is priviledged, so it is not like any
> user can create a DOS with bad SG_IO commands.
> 
> Also, the use case for this is a little silly in my opinion... Who wants to send
> a PIO multi-sector IO using a modern command like ATA 32? libata supports that
> if that is all that the drive can do. If the drive can do DMA and/or NCQ, then
> better commands will be used without relaying on a PIO passthrough command.
> 
> 

Thanks for the review and clarification. My testing showed the timeout
and blocked I/O described in the patch, but I do not have evidence of a
kernel crash. I understand the concern about parsing non-emulated ATA
passthrough commands in libata-scsi.

Thanks,
Gongyi
