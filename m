Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3148F155CA5
	for <linux-ide@vger.kernel.org>; Tue, 27 Aug 2024 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745016; cv=none; b=pwTkVvMr4uDkUinqAxaiiKARWpwVRPFFHae0hhp8cK3PDM6dlipLRQt84uVFE7b2L0aeLu0BIOB2zDnEmQHjBlLM+HFNY0xlWywf/USnJKwuLz2QON4+cQU+5GQ9s2SC99jVvn12qUI0d0Lf2FbUd8lvvD2n07T8tOvpPs9Chb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745016; c=relaxed/simple;
	bh=FWSXf7L88z9807G2qQwlsniOamK4JInMKoSfPYaeooo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ur+y3iCrw/pOOXV43itVoQu3TuESwoLdaIqqzEPPf0O13rtq/PXGrmTtu/9/EGBYcvBERVa6Yublrh1o9AM6a6s+jie6z040NFdSWAKuVWMK5sTs7VA8bQ1EXGLrcgvEGkJlKkEOVQj2REyLrA3201t09/TyOpC2DA6c9h5sEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDytT8tf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDytT8tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4D2C8B7A1;
	Tue, 27 Aug 2024 07:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724745015;
	bh=FWSXf7L88z9807G2qQwlsniOamK4JInMKoSfPYaeooo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PDytT8tfc9lf+grK4Wyj9KXYhkFIGS8TEkDist55cvDZXdX0SCSGm8wjbSC4m0ENc
	 nSLRneSt5w+uluY7nDsWbOoa/1H/yEhN+amyINjgydP6p/zlS0ptmVaTmQVmADAXhy
	 VN0y2ufCDOTsDgNZrQ7BsqSkn0rDYtzlROg8zNN6Lzg3jM5yIS4kKd3rzrADx30Ehk
	 tTnQDZtfKhx9Z7UKYOTTnNPz61eYVB3RaHuIhmcmySyD0mPZMwoXTmiLlra0nQR3DG
	 /lVuBYXXyp951na9/OkUJrv/LWghJJlDoCsz1JnWqdqZ4+cGKBoUgidCEMnNTYUL7Z
	 yQDQ0YBEMX1rw==
Message-ID: <b0f21e36-d29b-489a-9df8-83493d3992bc@kernel.org>
Date: Tue, 27 Aug 2024 16:50:14 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] ata: libata: Move ncq_sense_buf to struct ata_device
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20240826073106.56918-1-dlemoal@kernel.org>
 <20240826073106.56918-7-dlemoal@kernel.org> <ZsyVqTYDDNwGDCoo@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZsyVqTYDDNwGDCoo@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/24 23:48, Niklas Cassel wrote:
> On Mon, Aug 26, 2024 at 04:31:05PM +0900, Damien Le Moal wrote:
>> The ncq_sense_buf buffer field of struct ata_port is allocated and used
>> only for devices that support command duration limits. So move this
>> field out of struct ata_port and into struct ata_device together with
>> the CDL log buffer.
> 
> The ncq_sense_buf buf is currently only allocated if the device supports CDL,
> so the currently extra space that we take up in struct ata_port, for non-CDL
> devices is just an empty pointer.

No, we have cdl descriptor log page buffer (ap->cdl) which takes
ATA_LOG_CDL_SIZE (512 B). Furthermore, thinking of this some more, having that
buffer attached to the port is totally wrong if we are dealing with a pmp
attached device: we can have multiple devices supporting CDL that will all end
up overwriting that buffer. So this is actually a bug: either we move the cdl
log buffer to ata_device, or we must not probe for CDL in the case of a PMP
attached device. The latter is fine I think as CDL is really an enterprise
feature that is very unlikely to be used with consumer PMP. But the former is
more logical.

> Additionally, sector_buf, which we use for reading all the log pages belongs
> to struct ata_port, not struct ata_device.

Yes, but that buffer is only used in EH context when all devices attached to a
port (1 for most cases but more than 1 for PMP) are idle. So this is fine. This
buffer is not used at run-time.

> If you also still keep sector_buf in struct ata_port, then I think that this
> change makes the code more inconsistent. I would suggest to either move both
> or move none. But even then I don't really see the value of moving this from
> struct ata_port to ata_device.

The justification of the move is above. My commit message did not reflect this
though, so I will improve that. Also, it may make sense to squash this path with
patch 7... Will see how that looks.

-- 
Damien Le Moal
Western Digital Research

