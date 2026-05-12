Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D77360EED
	for <linux-ide@vger.kernel.org>; Tue, 12 May 2026 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616072; cv=none; b=EQPhszp+r228kjS6SHPdgkaL5PP8Nd4rtQVIxeSbHq6qIKY4Vi5mxzPDyYlIVdoJKoi2j0IuwZMzRcTDs6eof8f05F21JA7wJ8p/bTAPlNEibBUIqiPzAKN97nqcQotpCD+GCjR7D1q4Q+1jsHKq8gUzaP6ILdjDTSU890pkaq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616072; c=relaxed/simple;
	bh=balBgLOc6vinHXHm32vShxAn1rmRN41PpSSEcO9yYDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoovN8kDJhk7dMjaEe9Qhx7S5qs6b4mZ8pTwEn47OB2v+naXheYC38wdlk152jq1xaXkx1BSX8rElgp6zGGxvY0yug2mn5ZGdK2Jd5AD80IiDJUf191WPso7DTnJ/A1wY6YEGLGRWDbn/k2AP66qLmAbAMPG0zja2JM8AE4m9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=s+iabxTU; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="s+iabxTU"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gFSCB4MkJz1XM5kD;
	Tue, 12 May 2026 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778616067; x=1781208068; bh=zx5tz9FQv11GhtQ96CownC1E
	zqKq8y+7XrUsJnkh/Kg=; b=s+iabxTUT3QhfFJsPnKSif31fpXu8gVb9xY18UfJ
	cMQeVaf1JUipz9z01YJHeeeYdk+VA/3dHiti/aPniBayF+qkLBh9AEOBaX2+Ct1/
	JvCy8/5ENIj4oNHRc3gxXMhDP1MypJeQsQgWIFVJfVvnBK+SzqPq/KT9WhnnwX28
	g2r+6uGjNTeoB0fYdn0hqDOIWWrcGV/VFyY2uF940GEFAEDydC9GFhX9Bvmy1Qwd
	pt+PIkTTwefm8nAGR1XCdMzb7sPQapPnLlxGkgjxQRJfwpprmH215oTRUUfTKpcC
	UYP3Yp2RZiiSF9j1z8Z3RckOoIGlm8FHLJjOPJDXaaNnnQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EUUQNn99xP-j; Tue, 12 May 2026 20:01:07 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gFSC549HGz1XM5jn;
	Tue, 12 May 2026 20:01:05 +0000 (UTC)
Message-ID: <8a831bdf-6d32-45c4-bddc-9b14d6367407@acm.org>
Date: Tue, 12 May 2026 13:00:58 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Enable context analysis
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
 linux-ide@vger.kernel.org
References: <20260505042227.909666-1-bvanassche@acm.org>
 <agIJdj0vUGLAWsg1@ryzen>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <agIJdj0vUGLAWsg1@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/11/26 9:53 AM, Niklas Cassel wrote:
> 1) It seems that you are only checking for the EH mutex.
> 
> $ git grep -A 1 "LOCKING" drivers/ata/
> 
> Does have many functions with:
> 	LOCKING:
> 	spin_lock_irqsave(host lock)
> 
> Would it be possible to add __must_hold() annotations for these functions
> too, but for ap->lock instead of EH mutex ?

This is something I can't do myself. This is something that should be 
done by an ATA expert. I'm not an ATA expert.

> 2) There seems to be some files that did not get any annotations, e.g.
> drivers/ata/libata-scsi.c, drivers/ata/libata-sata.c,
> drivers/ata/libata-acpi.c, drivers/ata/libata-pmp.c.
> 
> Would it be possible to add annotations for these files too?

Just like for (1), since there are inconsistencies between the
"LOCKING:" documentation and the implementation, this is best done by
an ATA expert.

The goal of the annotations in this patch is to make sure that the build
doesn't break with CONTEXT_ANALYSIS := y. Any additional annotations can
be implemented as follow-up patches.

Thanks,

Bart.
