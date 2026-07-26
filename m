Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6E027876A;
	Sun, 26 Jul 2026 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785037324; cv=none; b=VkV2b8JLJKHNAIHNThYb5JV7uxayrLy0D1u907+kGsp1OHQ5J1MMhsrUJ2cLB6W5CkDrQ+bA5hrUMUgqShPyC+54n4U+E42QkUnGZ07cW+CEimK8q4KOHWxkgIsSs1pW9AIwDwP0c/1lInFM/UIw9RcvrAw2KRaeTie5q1ztezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785037324; c=relaxed/simple;
	bh=+VEmAZWgvA/9Emf15Ucc1Dkayc6aaN4acJMQrqOeUbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0x6YRmwYNkVZ7+/hI2hRrCnNBJLvRNQAj9E9Pknuf1YJFmGEzlIWdYEnHid4Mj9DW+0h+cIPL8P4hZDU8G9EaxzD5tq6LUv8tKBgCJPA/kGYQLQlKNlK5V7c7hidJ4mJxTHrGiLHaoK1eAZMtbkGZblndBUP6lL+WSXUdkYCos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aZ/2eASf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aZ/2eASf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VMhkzMlq9VJSi9IwZye0bz5HK4qNVDZdPzUmaIWn8d8=; b=aZ/2eASfSVmqM+0Dv/vQNw9JD2
	kCQXMBXV6jvNmZ1kHYhqIbfteID0c0azqGcyNDMH50LUtyD2sZgihZwBdp8dSkYSxYj6uF7xqjN7I
	5env7h+XCXyEpYYy+LDvEMqxU3CNmnweckm0RsAhEUzQ7qk13eTIeHiWPUXdO1Dy4K8V+iasmcHNH
	6zz8vf/z31Dr5pqcxE6iTIrpKbKDMPoG8vhxllhIKfcMqXgAkBNtZ2G6DJSNJNZ/cGpElNFCE3H9N
	iguN3s+kWDisGMIhx7jTIbgRN8FxKHwiE8JVCLPoBwoJXvXHXtHb0ThSoOE2jhEdPK8Zcp8vi4isO
	4ywLxWTA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnpkP-00000000rBh-2RIF;
	Sun, 26 Jul 2026 03:41:53 +0000
Message-ID: <85a068d0-8e37-49d2-93a5-3298b036726f@infradead.org>
Date: Sat, 25 Jul 2026 20:41:47 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: avoid kernel-doc warnings
To: Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
References: <20260725015209.1207666-1-rdunlap@infradead.org>
 <343c7dd0-c16c-419b-97f6-379692266761@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <343c7dd0-c16c-419b-97f6-379692266761@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/25/26 7:49 PM, Damien Le Moal wrote:
> On 7/25/26 10:52, Randy Dunlap wrote:
>> Modify comments to prevent kernel-doc warnings:
>> - use "/*" for a non-kernel-doc comment
>> - add a Returns: section for ata_id_major_version()
>>
>> Warning: include/linux/ata.h:770 Cannot find identifier on line:
>>  *
>> Warning: include/linux/ata.h:782 function parameter 'id' not described in 'ata_id_sct_data_tables'
>> Warning: include/linux/ata.h:782 expecting prototype for Word(). Prototype was for ata_id_sct_data_tables() instead
>> Warning: include/linux/ata.h:820 No description found for return value of 'ata_id_major_version'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: Damien Le Moal <dlemoal@kernel.org>
>> Cc: Niklas Cassel <cassel@kernel.org>
>> Cc: linux-ide@vger.kernel.org
>>
>>  include/linux/ata.h |    5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> --- linux-next-20260722.orig/include/linux/ata.h
>> +++ linux-next-20260722/include/linux/ata.h
>> @@ -767,8 +767,7 @@ static inline bool ata_id_sense_reportin
>>  	return id[ATA_ID_COMMAND_SET_4] & BIT(6);
>>  }
>>  
>> -/**
>> - *
>> +/*
>>   * Word: 206 - SCT Command Transport
>>   *    15:12 - Vendor Specific
>>   *     11:6 - Reserved
>> @@ -815,6 +814,8 @@ static inline bool ata_id_sct_supported(
>>   *
>>   *	The practical impact of this is that ata_id_major_version cannot
>>   *	reliably report on drives below ATA3.
>> + *
>> + *	Returns: major version of ATA drive level or %0 if unknown
> 
> Is the "%0% here intentional ? If yes, why ? Or is it a typo? If it is the
> latter, I can fix when applying.

It indicates to kernel-doc that it's a constant and should be printed
in code/monospace style.
But it's perfectly OK to drop it if you prefer that.

thanks.

>>   */
>>  
>>  static inline unsigned int ata_id_major_version(const u16 *id)
> 
> 

-- 
~Randy

