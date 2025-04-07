Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E519995B;
	Mon,  7 Apr 2025 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069967; cv=none; b=VZAPshlmQY8XD3ojb5TmHGpEW0khFH6nREXLXEKmuV274QKQqTycBGXSL9RIwQxjgzmdWuQepiobDonKlSqJ67c9k0t7zRkhY5OwkB58CE20Z4iWX0dgcUP8Sozh6c/FMpuGtuFkd1TlTGZqGdGWsPQjHnhndtNNoaEE5FmHerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069967; c=relaxed/simple;
	bh=GR2ivJYaDHAoq9H+EecLpwXwevmHqfY1EKcUe/k5xPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdDJkg+ekf0AiYsk57aMbbVogTobiV9sr9qsIOIYj1Np3/MQvp3URMdbI1liNlpqwa5Lc5JDzsEXnK8EjeDgGdCXpkBp5NNO23vAXbK6zbxeGYaPRcJLyJZstz8HmJfRP06NZcW9f91HQ9sRLHJc8qYRzFbee6CUN41PKm4zpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI01xcVX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI01xcVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526B8C4CEE9;
	Mon,  7 Apr 2025 23:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744069966;
	bh=GR2ivJYaDHAoq9H+EecLpwXwevmHqfY1EKcUe/k5xPE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jI01xcVXPhD3nFaKgAjNMPhdi+JboTmK57Ujodp4JCxgUJqT5YRtPf6gaKZgudRbE
	 b7wk4FUTNI9/jdjkysIgZ5GKLAC2Yd9caoI7/gsWNBoKKErQ0lFGnGcOpjeNKMPukQ
	 d2RDvnb5ecBRbnvNe+YgzIs7v+8C5GR7/eyIcN1jua0HZsX0UokmqXp7tqhNOLjiVl
	 vz6r48MsuFg3cZgutwKsQO7WLESSjwEpGo99STS10HpFtWD9ffT1kt20henEp8qzB2
	 1MX4aVCIKlWGJ/Ma7jaPlzx+6HNC6ZcUACyI6FEF1KWr3lCswHL/DXEjmcWii69UMu
	 pQB11zt0gHkgQ==
Message-ID: <d3218307-51fd-4731-b2aa-06ce4735d90c@kernel.org>
Date: Tue, 8 Apr 2025 08:52:44 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-scsi: Set INFORMATION sense data field
 consistently
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250403212924.306782-1-ipylypiv@google.com>
 <Z-_JExGDyO9pVTON@ryzen> <Z_AweMPLRJgBIBF3@google.com>
 <Z_OSQzA04-5v7SR0@ryzen> <Z_QXAA5Mq1kFP4Ao@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Z_QXAA5Mq1kFP4Ao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/04/08 3:18, Igor Pylypiv wrote:
> On Mon, Apr 07, 2025 at 10:52:19AM +0200, Niklas Cassel wrote:
>> On Fri, Apr 04, 2025 at 12:18:16PM -0700, Igor Pylypiv wrote:
>>>
>>> Agree. ATA Status Return sense data descriptor for ATA PASS-THOUGH commands
>>> already contains the ATA LBA in bytes [6..11] so it seems redundant to
>>> also include the same in the Information sense data descriptor.   
>>
>> Damien and I talked about this.
>>
>> Since this patch only affects non-PT commands, what it this patch actually
>> solving?
> 
> For ATA PASS-THROUGH + fixed format sense data + NCQ autosense, this patch
> eliminates reduntant writes to set the INFORMATION field and the VALID bit.
> 
> First write: scsi_set_sense_information() sets the INFORMATION field
> to ATA LBA (which is incorrect for ATA PASS-THROUGH).
> 
> Second write: ata_scsi_set_passthru_sense_fields() sets the INFORMATION
> field to ATA ERROR/STATUS/DEVICE/COUNT(7:0) as per SAT spec.
> 
> User space should not see an issue because second write overwrites
> the incorrect data from the first write. I think we should still fix
> this in case someone updates the code to remove the second write in
> the future.

OK. This now makes more sense. Please add all this description to the commit
message to clarify WHAT you are fixing, and clearly explain how the first
(useless) INFORMATION field write is removed.


>> So unless SCSI core does some specific handling based on the INFORMATION
>> field (and AFAICT, SCSI core only looks at SK/ASC/ASCQ), I can't see how
>> this patch can actually solve anything.
> 
> +1 the patch does not seem to solve any issues for non-PT commands besides
> a spec compliance which is not visible to a user.

If the above sequence applies to both passthrugh and regular IOs, then there is
no spec violation since the second write does set the INFORMATION filed to a
correct value.

> Deleting ata_scsi_set_sense_information() should work as well. If SCSI core
> does not use the INFORMATION field perhaps there is no need to set it at all?
> This will eliminate the reduntant writes for ATA PASS-THROUGH as well.

I do not think the scsi core use that field at all. But libata should still
behave correctly and act as a spec compliant SAT. So if SAT says that this field
should be set, then let's initialize it. If SAT says otherwise, let's do that.
I have not checked SAT specs. Have you ?


-- 
Damien Le Moal
Western Digital Research
