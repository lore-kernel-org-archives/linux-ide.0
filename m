Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04011CAB1;
	Wed, 17 Jul 2024 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221903; cv=none; b=c4CiLGgITpIh2nUP0OBL3vnnkwRm7OYIAnDFbgDcxFjTJ/yXbAfKoMDlUN5261/iKLkEEkO9mrQ13kvNLz6hT2wZ5nPMrirhSVjM5p0FUywOEEm8NiPp3VdmvtvzbYBBdtbuVGlwAlXlqRMAHfK8I1dsSMiNrBL630o09WFySKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221903; c=relaxed/simple;
	bh=BsJB1VZLWv8cQf5g96mezOqaXTKelngBefAByQYHKGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqXce63sUZR1uCU7WMOHSJnWP1Df5GHxNZEg66KxJfhF9tSNbdu55YwJ7k+69vvz4JLRzKZrspzMSZXnQ1BaDzRohplg77or3aCduofxjMe+Etr9AvaV9WCyc17smmk3rCyYs1lgJlhIWuNYJXCdyywbFjeXqhlXJh6JGH9Frck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4vbhO9y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4vbhO9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5785C32782;
	Wed, 17 Jul 2024 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721221903;
	bh=BsJB1VZLWv8cQf5g96mezOqaXTKelngBefAByQYHKGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4vbhO9yEsuI9nH3vG8q7WKhBuI+L7PR9fgGOYOzADET3EuPNvoI8oEvxBmE8LDi2
	 kejGp/+k3eqqU+J96yiMrOgsoie6QFprPW32l2b765dLkQV9gOhAaGRH9pRCHTvqb6
	 SdTY6/BGFuksI/KpjFr8DzDZcwVvXs1ABXaDGBojyCEHECvjncpDn0tTMRhkH51XtS
	 dxU2rc+4l0o8tPvMKmulfzmMkNh1d5SIjR8MSFKSCcVms6aTEPU1V8Sy2LUj1FvxQY
	 LxAx+Q+U8q2suGTzsWALXdM1hbRjMbj6m8vSdL760USynoZJGAKxcp188krkZ2a3xu
	 oIczMD7DLqI0Q==
Date: Wed, 17 Jul 2024 15:11:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rayyan Ansari <rayyan.ansari@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] ARM: dts: qcom: {a,i}pq8064: correct clock-names in
 sata node
Message-ID: <ZpfDCStcxnec712U@ryzen.lan>
References: <20240716105245.49549-1-rayyan.ansari@linaro.org>
 <20240716105245.49549-2-rayyan.ansari@linaro.org>
 <ZpeEq_QmV-aerpCW@ryzen.lan>
 <D2ROZY3KYF19.3KJC3CS82AWMO@linaro.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2ROZY3KYF19.3KJC3CS82AWMO@linaro.org>

On Wed, Jul 17, 2024 at 10:05:09AM +0100, Rayyan Ansari wrote:
> 
> Hi Niklas,
> 
> Yes, this patch does not depend on the following two patches, I just
> thought that sending this as a series would make sense given that
> patches 2-3 would surface this error (as we can run dtbs_check against
> yaml bindings but not text bindings).

Usually, DT maintainers prefer for DT bindings to go via subsystem trees
(in this case libata).

I guess DT maintainers could have picked the whole series, as they do
occasionally, but they seem to want to avoid this as much as possible.


In this case, considering that the DTS change (patch 1/3) is a strict fix,
I think that it should be merged ASAP (target 6.11 instead of 6.12).

We will queue the DT binding changes for 6.12.

When also taking into consideration that the DT bindings and DTS changes
have different trees, splitting the series was probably the right move.


Kind regards,
Niklas
