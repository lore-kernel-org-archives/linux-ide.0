Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793248659;
	b=SFzC38u7IlKmdOAbnrnH/pcK8ojrYPx3xQzhY4mD9Nj9///6Vsi5PIHpF7HfJhEJNGLh
	 ofW2LBxBFjkQ3LeF6uDiDUweB5Pnzh75r5DeRdZ/0SQ20BPnIbneQnmR6iNuJIjYZTF4y
	 /8fvoYFQLf12nw+rQrB48V1GYN5bJUmkf7sNFjwnHCOa94VoHh2xG/9+XdRJhoRSshSpt
	 VRPOcspCmpzuoOhSmLiFCSYfE0dU1EVFuKbTqUStrOleXz5ZbP99D2NsfwzOqyNPi/kfH
	 hR0rHR6ZgPoaMlfX09sT8Hc80tJE4hh6njhwpooy1Hwgfd53OFpf0XPNDMdmeAuibkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793248659;
	h=DMARC-Filter:DKIM-Signature:User-Agent:Message-Id:X-Original-From:
	 Content-Type:X-Lms-Return-Path:Cc:From:Subject:In-Reply-To:To:Date:
	 References:Mime-Version:Content-Transfer-Encoding;
	bh=pxx2va2K2g7IdMw0G+rSebc/KMLdkp6PwljQLQMAqII=;
	b=0t46wXsPwqQUaJIsKIYeAcnSGIOQjP0vV+mYJnf8H1E4EPSM/LxZVACQPHLkHquknjE0
	 /H23M6ESReCdHDY6WMEm+iOgajfsnP/uPTEsebtP6SalFLzYV5KWd368pNuSSomeR4HCX
	 HusmAzi4GeA0B7gdUlB4eOc99x83Xav57x1pBJw3Jr4UUXuEU9Z+xZO/DtjBYQCKcbOzj
	 eyal+GJY0uCGBk2xroo35m/7PpMs84A1lEyL7nmYBmAFDS836f2IOmKefcqcTky8agPYD
	 1IageHVzRQcqw4WmPpVPWK38ahQZfdiNnpyO9dGuDp62q+ndnrjsqDKDuavHq4CBhHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b="oT3z1/88";
	arc=none smtp.remote-ip=209.127.230.111
Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A1606A31D
	for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 04:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 606A1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=oT3z1/88
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793248652; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=pxx2va2K2g7IdMw0G+rSebc/KMLdkp6PwljQLQMAqII=;
 b=oT3z1/88/GKVKEFm+hzibl3+panUZQfdrGd2+tnFYXthn4d8TkUDCWK4edOVPCUOch6pKH
 wTTPdtUJjkcFPYFjaofOe6n6c9m6YMfzYl1SmzWJwCVv6ZnCeyZWmtPIWTj42qGswMGZc1
 82hUy8kSTAoueW0mb+teYd6jcQR1JPFMYcvED9qN8okyLOjJraC5p7VzLR+W7UDa1hvzUS
 I/ORUgLWfkH5Q1O5uTcjwEp35OxiFydoOZVjNLW9L+G4BnWMzg5u9zUsRlgazbfOIqEIIa
 o9KRqK3i72PbHoNcg5r9uwZ13UoBDlpX0euvznJuDDE1j19wmV4DnFLwPEowPQ==
User-Agent: Mozilla Thunderbird
Message-Id: <36648b88-c295-4acb-8b6e-25d742d50946@bytedance.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26ae2cd8a+b99e4a+vger.kernel.org+zhaogongyi@bytedance.com>
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Subject: Re: [PATCH v2] ata: libata-scsi: reject data-in commands with a data-out buffer
In-Reply-To: <8ec9e401-4c00-42fe-b997-228e05ed9c2a@kernel.org>
To: "Damien Le Moal" <dlemoal@kernel.org>, 
	"Niklas Cassel" <cassel@kernel.org>
Date: Thu, 29 Oct 2026 12:37:16 +0800
References: <20261027090809.94126-1-zhaogongyi@bytedance.com> <20261028113903.19569-1-zhaogongyi@bytedance.com> <8ec9e401-4c00-42fe-b997-228e05ed9c2a@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Damien,

Thanks for the review.

On 10/28/26 9:59 PM, Damien Le Moal wrote:
> On 2026/10/28 18:39, Zhao Gongyi wrote:
> 
> No they cannot, as long as the kernel is correct for internally issued commands.
> But t is not clear here if you are still talking about commands passed through
> SG_IO.
> 

Yes, by "translated commands" I meant commands submitted through SG_IO
and subsequently translated by libata, not commands issued internally
by the kernel. I will make that explicit and narrow the description to
the affected ZBC IN and GET PHYSICAL ELEMENT STATUS paths.

> 
> Why is this being checked here and not in the SCSI layer (sg driver and bsg)? It
> seems sensible to check this there.
> 

I checked the SG and BSG submission paths. For data-direction purposes,
they derive the request direction from the SG_IO descriptor and otherwise
treat the CDB as opaque. I could not find a generic helper that derives
the transfer direction of arbitrary standard, service-action, ATA
pass-through, and vendor-specific CDBs.

For simulated commands, libata itself performs the CPU-side write. For
the ZBC IN and GET PHYSICAL ELEMENT STATUS translation paths, the actual
ATA data direction is known after xlat_func() has built qc->tf, and their
completion handlers may modify the receive buffer.

This is why I currently think that checking these paths in libata is the
smallest fix suitable for stable. A broader SG/BSG direction-validation
policy may also be useful, but would likely be a separate change.

> 
> Test details are not needed in the commit message.
> 

Agreed. I will remove the detailed validation results from the commit
message and keep them below the --- separator.

> 
> The CDB may be perfectly correct. The error is in the SG_IO descriptor setup,
> NOT in the CDB. So returning invalid field in CDB seems very misleading.
> This is not something that SAT defines as far as I know, so we need to find a
> sense code that is more informative. Please have a loo at
> include/scsi/scsi_sense.h to see if something better exist.
> 

Agreed. INVALID FIELD IN CDB is misleading here. I propose returning
ABORTED COMMAND / DATA PHASE ERROR (4b/00) instead.

Would this approach be acceptable? If so, I will send a v3 with the
clarified description, the shorter commit message, and the updated sense
data.

Thanks,
Gongyi
