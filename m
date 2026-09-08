Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA74A3F23
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858279; cv=none; b=K9Z0uUCDUTcdbB0KJB6/kP97q+W8juy4LPGDhPblB2w/XqlSlgR/6xG1T1uIcCagwS49PBS+aHijy5Fo6Kw6OVw9RKDzTNMbJ9JTJVHyCakgvW09oNnmdSCuTYVQa8UgC+EmuPgRZNbzieGEVyxxlrcDwTwOrZx1vZP5Fx/HPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858279; c=relaxed/simple;
	bh=nl0TXoKBPlA5zlwPstopqWen+goLxqiQjU57GvWWoCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pssKMYDB2du0N/FFhLOOB0t51Oq7MLQOoZ0QNyEHiqGCg4INkgJ9nl9EF/KOqVPuuDS9WYcV7WoDB0wb4sdprg+dMONGHzQOXOF7umotTeQu22se59tyHrfbvTyExD3CC8mu7y1rs5EbtImq3UkT4GnD+Slo2r90PzJO5TFcjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXTo7dds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXTo7dds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D9F1F00A3A;
	Tue,  8 Sep 2026 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788858276;
	bh=eBcJE46qpGOaQ5YTi/ar0FSLNCcMkg5PRiwG1QACxsA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jXTo7ddsbX07a6PkdlLnLf0Po/zzUb1B1CsuevTZyQT0/bLAFdT8K8ClPlsBtp3tc
	 4FiJOxG+r8vQAT0F+V8MGhwBsWd6usxe3ug2Lf0B0aWJfXFn0HmsoSS5RU9vOez1d6
	 vFHHX74MBWgQqXBYTV+aXtn166iq0PGODSTNM2qmy7RWE2IhAqhF51l/fjwlOk9Ni4
	 GMLPT4XwM+Z5CuGO6v+5Qz8X796d0mvRqmjP0Ob7VU3AlBJtIFzLwIjqhGbr6Jf/7n
	 20kUGhqLfLOAUNDKEUVtYsuw4etRZtXRDewM3xJqerGF7DYQW2Rqt81+C3JfZZLgya
	 a6sV0FY/GwCPg==
Message-ID: <ee7fe885-9ccd-44b3-9f5a-4ec14e2b76b2@kernel.org>
Date: Tue, 8 Sep 2026 18:04:32 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
To: Niklas Cassel <cassel@kernel.org>
Cc: Li Jun <lijun01@kylinos.cn>, linux-ide@vger.kernel.org
References: <20260908061025.3580261-1-lijun01@kylinos.cn>
 <e0412d20-6503-4737-8c9c-94f44f2c397a@kernel.org> <ap_LL-EaGZUmCaaq@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ap_LL-EaGZUmCaaq@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 17:45, Niklas Cassel wrote:
> On Tue, Sep 08, 2026 at 03:13:49PM +0900, Damien Le Moal wrote:
>> On 9/8/26 15:10, Li Jun wrote:
>>> Replace the deprecated SIMPLE_DEV_PM_OPS macro with the recommended
>>> DEFINE_SIMPLE_DEV_PM_OPS. Use pm_ptr(&ahci_da850_pm_ops) to complete
>>> the API migration and allow the structure to be correctly dropped
>>> when CONFIG_PM=n.
>>>
>>> Signed-off-by: Li Jun <lijun01@kylinos.cn>
>>> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>>> ---
>>> changelogs:
>>> -add pm_ptr for ahci_da850_pm_ops in ahci_da850_driver.
>>> -revise grammar and alignment issues.
>>> ---
>>>  drivers/ata/ahci_da850.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
>>> index 4e53ff96d712..469cf015bbf0 100644
>>> --- a/drivers/ata/ahci_da850.c
>>> +++ b/drivers/ata/ahci_da850.c
>>> @@ -218,8 +218,8 @@ static int ahci_da850_probe(struct platform_device *pdev)
>>>  	return rc;
>>>  }
>>>  
>>> -static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
>>> -			 ahci_platform_resume);
>>> +static DEFINE_SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
>>> +								ahci_platform_resume);
>>
>> You resent the same v3... Did you mean to send a fixed v4? Or is it me for some
>> reason getting the same patch email twice?
> 
> I just received a single v2 and a single v3.

Indeed, I missed v3 in the email subject.

> 
> The commit log is different from v2 and v3, and your Review-tag was picked
> up. However, the indentation still looks wrong. It seems to have 8 tabs
> instead of 4.

And yes, the indentation is still wrong.
Maybe fix it when applying?

> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research
