Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92B215F46
	for <linux-ide@vger.kernel.org>; Thu,  9 Jan 2025 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422401; cv=none; b=nbck/EdbDfSZh05nt8dqLZpT5x+SetpYlWsVhFj2drlOMJB3/seBgD73U7WPbIR6AFcxy6okV+Cq3NipWxddhXQV3d/r5ov2ijnFyH/TOBHL47rdclum1m8qPbXJh4M1FMfSPk0EBz0pNOedwIouhX3n1u01P7hNGL6YqcsV/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422401; c=relaxed/simple;
	bh=aVXjT70t+JGWdcKSPDDAOjy07uTOfyKVD0lh0TfMe7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ef2x2FYbO7ykMd7HpUlBBpL0PCRLLQX9fGU3UkQO6fcVI6n22/PFYrjWeAPFxk6pAycEUmrUPp19eAwR1jV+DVMM8Tx7U3PoIXy1ufTBXnUh7tR2QP3ZZebFraQ5qy/9rqGC3J79/iJoXXXjcQK0ANoBl1M5dy4wfkrIlQc759c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=IJZXyf/L; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="IJZXyf/L"
Received: from wolf.philpem.me.uk (148.163.187.81.in-addr.arpa [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 17DBBBD152;
	Thu,  9 Jan 2025 11:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1736422392;
	bh=aVXjT70t+JGWdcKSPDDAOjy07uTOfyKVD0lh0TfMe7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IJZXyf/LA4XTotqe+rsBSY1dGJZNsYLVxM+SCmTrR1GfxwHle5y+ndUSW73+50TYE
	 2eH7CXDjCpG6JsG5Vj/JRpsaPPtFFccEfM9faInGXFpu1UK7Q15OrawHPMmBQj5OBt
	 MCPnT/c0QNykEKhhTSTfFUsfIbUEOnZx8IuB4Kz0=
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 63D0A2C0546;
	Thu,  9 Jan 2025 11:33:11 +0000 (GMT)
Message-ID: <8d8be593-51c5-4029-b310-a0d9082f5eaa@philpem.me.uk>
Date: Thu, 9 Jan 2025 11:33:11 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear UNIT
 ATTENTION"
To: Hannes Reinecke <hare@suse.de>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen> <0d1ec6ec-1938-419d-90ff-d4faf2ebaea6@suse.de>
Content-Language: en-GB
From: Philip Pemberton <lists@philpem.me.uk>
In-Reply-To: <0d1ec6ec-1938-419d-90ff-d4faf2ebaea6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/01/2025 07:17, Hannes Reinecke wrote:
> Which makes me wonder: does the SATA-to-PATA support ATAPI? It has been 
> removed from recent ATA specifications, so there's a chance the bridge 
> simply doesn't implement it ...

It seems to -- if I use the SATA-to-PATA adapter to put the drive in the 
Knoppix PC, the Zip drive works fine.

-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/
