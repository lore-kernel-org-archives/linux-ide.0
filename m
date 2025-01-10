Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21F19ABDE;
	Fri, 10 Jan 2025 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510573; cv=none; b=pIOaeV7UNunXhR0G/og3EJmOLRhfbyRo3qRzf6NlKlQNcxKX3fChCyUZmU+LoPogVjthNOvwKXYHBXqID2ruOlvkwRAJfsdu+KcNfjl9YMNPrG7dHG+PnOwxFb0dfkB/4qDE5t3l4dv0MONr5dRjNGcNT+mK0CCi+Ua76P2pzQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510573; c=relaxed/simple;
	bh=KRLoAbKS0jXsbg60i2JNi1ViMRnPQJoNJ1ZdkHnXhv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBL24iSHzx/4bZfDjkAPN0iRe3b9BvrTuTrq6PuJp48cs0FLY8GoGJY39pn+BXY/wm/8PzWV98nPyVuRo0bac1yqDCJnvdIgNH/36yVALhCn6W1Cx0EhObKfKY3Qolk++1YKtpBuAjRin/SrAqq1FLPaFgYmfj5BUshOoPHQ63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzGKnVSb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzGKnVSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDBCC4CED6;
	Fri, 10 Jan 2025 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736510572;
	bh=KRLoAbKS0jXsbg60i2JNi1ViMRnPQJoNJ1ZdkHnXhv4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DzGKnVSbVD8HlXHejGcPt07VIeUuIRlD33qcVleNWRLAt/9nwKQUTi7tkyrOUeKSF
	 qUlJIqlSh8cpg78nSwehhykakWVO4jWFwVwj+LjbpzGGrGRLapCEqDoBXJM0kUuJcU
	 pnzTfLMQ686Zyu0Ec8FXW26tddl8c/Wx2s7UTZBGfLtxABzfOuMP97XTWjojDKZSGj
	 y6CU8jgm9lMjhtSaC28Oqcsve5e+Y9/5e9knhsafXytzQaXqEa+6mZlJNxN6Dfbs+0
	 G1OCb8G8LRDBSR+1nNpy77vq1IeCCr/9KPnWzEPR8d7zy/BwhAmKKqClzCAypNyKls
	 ee+Xfycr+fF5w==
Message-ID: <cfecaa65-f6bc-48c1-9295-9bfe18f13db3@kernel.org>
Date: Fri, 10 Jan 2025 21:02:50 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ahci: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
To: Niklas Cassel <cassel@kernel.org>
Cc: Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250109175427.64384-1-rgallaispou@gmail.com>
 <07a7177d-7705-4eb5-a11e-02a9429ffac2@kernel.org>
 <Z4EDKUb+hO0ovV2i@x1-carbon>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z4EDKUb+hO0ovV2i@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 20:23, Niklas Cassel wrote:
>>> -#ifdef CONFIG_PM_SLEEP
>>>  static int st_ahci_suspend(struct device *dev)
>>>  {
>>>  	struct ata_host *host = dev_get_drvdata(dev);
>>> @@ -221,9 +220,8 @@ static int st_ahci_resume(struct device *dev)
>>>  
>>>  	return ahci_platform_resume_host(dev);
>>>  }
>>> -#endif
>>
>> I do not think you can remove the ifdef here. Otherwise, there is going to be a
>> compilation warning when CONFIG_PM_SLEEP is not enabled. No ?
> 
> Look at the pm_sleep_ptr macro:
> include/linux/pm.h:#define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
> 
> I would expect the function should be optimized out by the compiler
> using dead code elimination.

Indeed. Just tried and no warning. I was expecting a "defined but not used"
warning, but none showed up. So all good.

> Raphael, perhaps you could show the before and after output
> using ./scripts/bloat-o-meter ?
> (When the config is not enabled: before and after your patch.)

No need to do that I guess. But there are 17 other ata driver that set .pm
operations. What about these ? Don't they need the same treatment as ahci_st ?
15 of these also use SIMPLE_DEV_PM_OPS() which can be replaced with
DEFINE_SIMPLE_DEV_PM_OPS() also, no ?

Do you want us to do that cleanup ? (fine with me).

-- 
Damien Le Moal
Western Digital Research
