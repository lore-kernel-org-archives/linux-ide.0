Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D032A8D0
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004206; cv=none; b=D44KwUeJucmciKHNpogXPEgS2PRTu2aXzrX+l1trH6x46Mx0V+Zb/IpH6KavlJwG+L+jqnG693TGO6ojFtQFT73crVwbqir/LSij7n/z3Oo5J927gHXbK0250PAPN3L8ik4+TkccXD/3E0clb3Aa04rZoiV1DxphgH/gfaQavf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004206; c=relaxed/simple;
	bh=lLRTrcc9DIZ+xcFtLYsueAgQgEhmZgC743BWQPk8SCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iO7eJCuajhVuij2AVO4sdTBj1PBh1Q80MJn7afuSgX06DgUgyDs/6CMPQKgvR/uCigQNl4lZdjdw2kouSCrQRmWfh1+vA7ARin64O76S/iRbs/D7vRpO+dgWDx50g5W0wjRSQZGQJ9SBm4QkwBczJX5YoLIM+b9isGSMJOjtfQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XNmPcRW1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k782OOh4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XNmPcRW1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k782OOh4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XNmPcRW1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k782OOh4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XNmPcRW1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k782OOh4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 195F61F38D;
	Fri, 27 Jun 2025 06:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751004203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvmkKucRSbKweex95Msc+4zZatfUmW9QVBBfpWrhqwc=;
	b=XNmPcRW1l5q75jSuHhsva9/mAyEVadoUNOu4inbzf7TwRig+0uMbN08//QbEduiznSAG/C
	vQZ12aFZAqe9QqrhUH+EOCQSTMdBtpluMupBrpGF8nCQ2zN2i8ufoXiJXnNjbNb3r69WKN
	ykHPgSvsCylJhmhDIK1YavK5dYwo9Ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751004203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvmkKucRSbKweex95Msc+4zZatfUmW9QVBBfpWrhqwc=;
	b=k782OOh4l6ApxfAii0GFKCQu2u/hDAYfQYxwPmiE37xwqzY6PHvH04HRuia8B9sRCLzWEC
	6qhHDLwkk6IIXWDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751004203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvmkKucRSbKweex95Msc+4zZatfUmW9QVBBfpWrhqwc=;
	b=XNmPcRW1l5q75jSuHhsva9/mAyEVadoUNOu4inbzf7TwRig+0uMbN08//QbEduiznSAG/C
	vQZ12aFZAqe9QqrhUH+EOCQSTMdBtpluMupBrpGF8nCQ2zN2i8ufoXiJXnNjbNb3r69WKN
	ykHPgSvsCylJhmhDIK1YavK5dYwo9Ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751004203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvmkKucRSbKweex95Msc+4zZatfUmW9QVBBfpWrhqwc=;
	b=k782OOh4l6ApxfAii0GFKCQu2u/hDAYfQYxwPmiE37xwqzY6PHvH04HRuia8B9sRCLzWEC
	6qhHDLwkk6IIXWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3BD413786;
	Fri, 27 Jun 2025 06:03:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VZ6BNSo0XmhuMQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Jun 2025 06:03:22 +0000
Message-ID: <347157db-8a01-47ae-9dba-c46c77bae824@suse.de>
Date: Fri, 27 Jun 2025 08:03:22 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] ata: Fix SATA_MOBILE_LPM_POLICY description in
 Kconfig
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250627011155.701125-1-dlemoal@kernel.org>
 <20250627011155.701125-4-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250627011155.701125-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 6/27/25 03:11, Damien Le Moal wrote:
> Improve the description of the possible default SATA link power
> management policies and add the missing description for policy 5.
> No functional changes.
> 
> Fixes: a5ec5a7bfd1f ("ata: ahci: Support state with min power but Partial low power state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/Kconfig | 36 ++++++++++++++++++++++++++----------
>   1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index e00536b49552..1d53d7b568bd 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -117,23 +117,39 @@ config SATA_AHCI
>   
>   config SATA_MOBILE_LPM_POLICY
>   	int "Default SATA Link Power Management policy"
> -	range 0 4
> +	range 0 5
>   	default 3
>   	depends on SATA_AHCI
>   	help
>   	  Select the Default SATA Link Power Management (LPM) policy to use
>   	  for chipsets / "South Bridges" supporting low-power modes. Such
>   	  chipsets are ubiquitous across laptops, desktops and servers.
> -
> -	  The value set has the following meanings:
> +	  Each policy combines power saving states and features:
> +	   - Partial: The Phy logic is powered but is in a reduced power
> +                      state. The exit latency from this state is no longer than
> +                      10us).
> +	   - Slumber: The Phy logic is powered but is in an even lower power
> +                      state. The exit latency from this state is potentially
> +		      longer, but no longer than 10ms.
> +	   - DevSleep: The Phy logic may be powered down. The exit latency from
> +	               this state is no longer than 20 ms, unless otherwise
> +		       specified by DETO in the device Identify Device Data log.
> +	   - HIPM: Host Initiated Power Management (host automatic transisitons
> +		   to partial and slumber).
> +	   - DIPM: Device Initiated Power Management (device automatic
> +		   transitions to partial and slumber).
> +
> +	  The possible values for the default SATA link power management
> +	  policies are:
>   		0 => Keep firmware settings
> -		1 => Maximum performance
> -		2 => Medium power
> -		3 => Medium power with Device Initiated PM enabled
> -		4 => Minimum power
> -
> -	  Note "Minimum power" is known to cause issues, including disk
> -	  corruption, with some disks and should not be used.
> +		1 => No power savings (maximum performance)
> +		2 => HIPM (Partial)
> +		3 => HIPM (Partial) and DIPM (Partial and Slumber)
> +		4 => HIPM (Partial and DevSleep) and DIPM (Partial and Slumber)
> +		5 => HIPM (Slumber and DevSleep) and DIPM (Partial and Slumber)
> +
> +	  Excluding the value 0, higher values represent policies with higher
> +	  power savings.
>   
>   config SATA_AHCI_PLATFORM
>   	tristate "Platform AHCI SATA support"

Hmm. Isn't it worth creating an official documentation somewhere in
Documentation/* to have this available without having to look at the
source code?

Otherwise:
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
