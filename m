Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF612B8B
	for <linux-ide@vger.kernel.org>; Thu, 29 Aug 2024 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893660; cv=none; b=bdo7qm3RuwQKgHVTTuFBGstADeI9WahGUA4o0r1h+v//B+YdUVBuuYeHsF9LxYuwaphq7yAJT7WD+OiDZtAw2r/yjn1d60owmuv8tXSkUASCfULQcqA8gJqWOZ3zG7SAnyttSmDhqWvOLx8bfmkdEgKmFwLnThajj4jdMrbwW0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893660; c=relaxed/simple;
	bh=Uxq6qcqASH9p24qUuB9gmI7VLUl7YCEA7/9dKfNj1eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csMlmbpju8Cu/OLJ1ON84f0RUFzFB8Lps4GzNmFk+6uR3Hu+/YcGPvy/1LRMZ7NLPjBHdbDqwZaNA6Qa7wFEHb/45n2Bf6giGKOjt6sf7rqo/a7cxx5PYOLuUV8dSMSdwvOZ0861o1xnk8Fv9ZB3eMnwMdgFHaWNNfndHAFvwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNw0Jkxf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNw0Jkxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB91C4CEC0;
	Thu, 29 Aug 2024 01:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893659;
	bh=Uxq6qcqASH9p24qUuB9gmI7VLUl7YCEA7/9dKfNj1eU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LNw0JkxfmpRdOeHLQEN+S/z9bNE8z0Cz/9J4zKlvlNWMs6oZzJeUpy4WtqBK41S6H
	 BUvN8yr/0HbKVPx20C0NcAv0CEo95PO4zXO27XiY9BLkRh5trrCezZ+Z/e/o/kQxzg
	 brBBnHjDiCF0xspreLPBiQmbjcWbMoPHzLDad9gnlh68vbFWfGv9u77OI0pK8HL3Pq
	 0QS1cQmhyMUM1NzlpigIHfhW8s0MSMlWF8VKqtaLT8xQYBws+Y4Iea+cNeYZBu3QKU
	 jq/m5sVy/tW97yRlMYKWzw/yp3AWbHnfdfFqIp8uqujFm1EmQ2PGNKT8Uuy+0t0VV/
	 IVNwYAs7ncwAw==
Message-ID: <37c816a9-7796-49df-8b87-7e302aa4562b@kernel.org>
Date: Thu, 29 Aug 2024 10:07:38 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata: Add helper ata_eh_decide_disposition()
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20240828072703.339060-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240828072703.339060-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/24 16:27, Niklas Cassel wrote:
> Every time I see libata code calling scsi_check_sense(), I get confused
> why the code path that is working fine for SCSI code, is not sufficient
> for libata code.
> 
> The reason is that SCSI usually gets the sense data as part of the
> completion, and will thus automatically call scsi_check_sense(), which
> will set the SCSI ML byte (if any).
> 
> However, for libata queued commands, we always need to fetch the sense
> data via SCSI EH, and thus do not get the luxury of having
> scsi_check_sense() called automatically.
> 
> Add a new helper, ata_eh_decide_disposition(), that has a ata_eh_ prefix
> to more clearly highlight that this is only needed for code called by EH,
> while also having a similar name to scsi_decide_disposition(), such that
> it is easier to compare the libata code with the equivalent SCSI code.
> 
> Also add a big kdoc comment explaining why this helper is called/needed in
> the first place.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Applied to for-6.12. Thanks !

-- 
Damien Le Moal
Western Digital Research

