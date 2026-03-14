Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBCB1EDA2C
	for <linux-ide@vger.kernel.org>; Sat, 14 Mar 2026 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773479004; cv=none; b=XiR+1rD0IGyN/vLr5h2Bvb/HILQ0NogNhEJUowPHezzGMKo7yK4fiTkSO5bZa20E1RQe6K1LuZBFtPkAJrOcsSwX+3zq2bYuMP7SJ8PMN+V72DIk9xpBxXwuX6tx5o0kYAe5dYQYgS0b87Yi2jXCF7VEzPqDgADJjvrXnKCU1b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773479004; c=relaxed/simple;
	bh=gDpeedbh6c7vlZtRjMF9kI9q0COEpG5vo0fIwhhOo40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnXO+ZwBuM16afNIdJucQikeEhAdhyqGUU8mZWPmiwJ4ys4yPuiAyEY2PreWecM4h/H6zTBSGW1LUP+azKUBa9x11YVGitwsq5v9HEB1KdmoommdWtffkAtUNwD4mCLp8DMv7u+hoAtAchSA4S4SFnJombNRQQD48zDk2YtlRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh3/TWkW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh3/TWkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60558C116C6;
	Sat, 14 Mar 2026 09:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773479003;
	bh=gDpeedbh6c7vlZtRjMF9kI9q0COEpG5vo0fIwhhOo40=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dh3/TWkWEyI7woMSi5WSWkbQpgTiiae8eZyn3DGB9ITB4tOhDfYdkvuOZf7xH1U/l
	 rZ/PRnm4mTOH3Vi7TQOJEqhevbS0JAIqAaUdL6bMjZU469H+aGL7md6YQWbYZrYUXG
	 gYMU1QNk4XV+t1E8Q9/A+3z0SxTAA9iIJC4OfFHYw4aAifdOylDdtdNfR9pY5p7Hvq
	 jVTdwG9QfbGLKWSYvGW/Q1j5vf5vGGCDC90avUDZH7WATBfEUo68av/mJ0VK/N9MqQ
	 yuiLS4hweEQurWcvp5zTCzPvnmZsUOBUBtz+zaFqeVD8Vk59Qe8EYN7p+qvcTZ0zGm
	 NM25YGam7N1wg==
Message-ID: <e1b944e1-e0ae-4329-be4b-f6b278df6cd8@kernel.org>
Date: Sat, 14 Mar 2026 18:03:21 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] libata/AHCI: ADATA SU680 on Dell Vostro 15 3510 shows
 repeated FPDMA timeouts, ATA bus errors, hard link resets, GPT/metadata
 instability, and SMART reset-counter inflation unless link power management
 is forced to max_performance
To: Mohammad Khaled Bayan <mhd.khaled.bayan@gmail.com>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <CABn6530JJUe5vYA9f-TBY9fgi-wacqNriVPeiKD0EfYQ+ZPi0A@mail.gmail.com>
 <d3ab269c-697d-4768-b7c7-61d0beed3879@kernel.org>
 <CABn6531ukajHmBNvq5z-UKN8nX8Uf2a86+caMcpGk4kGDFEbsQ@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CABn6531ukajHmBNvq5z-UKN8nX8Uf2a86+caMcpGk4kGDFEbsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/26 21:02, Mohammad Khaled Bayan wrote:
> On 3/13/26 09:37, Damien Le Moal wrote:
>> Please send the exact model string reported by "hdparm -I".
>> We need to quirk this device with ATA_QUIRK_NOLPM.
> 
> The exact IDENTIFY model string from hdparm -I is:
> 
>     Model Number:    ADATA SU680
> 
> I would be happy to test an ATA_QUIRK_NOLPM patch as well.
> 
> Regards,
> Mohammad Khaled Bayan

Can you try this patch please ?

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6c4e567b6582..374993031895 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4188,6 +4188,9 @@ static const struct ata_dev_quirks_entry
__ata_dev_quirks[] = {
        { "ST3320[68]13AS",     "SD1[5-9]",     ATA_QUIRK_NONCQ |
                                                ATA_QUIRK_FIRMWARE_WARN },

+       /* ADATA devices with LPM issues. */
+       { "ADATA SU680",        NULL,           ATA_QUIRK_NOLPM },
+
        /* Seagate disks with LPM issues */
        { "ST1000DM010-2EP102", NULL,           ATA_QUIRK_NOLPM },
        { "ST2000DM008-2FR102", NULL,           ATA_QUIRK_NOLPM },


-- 
Damien Le Moal
Western Digital Research
