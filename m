Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9C2836AF
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785494; cv=none; b=DfJjhbtzA6IEvB/DpZlrQQLa4fy3XJpDubzX2mlQ2ADk+PEecEX9hXo5MRFVkIZYasR0/myVvaBFI+8VNkwv4+LN+k2JlLK9lHUz0qjGC57Heyb+uViFGIkZVlB5ZgYp4ez57V+DsjtAru4vOOCyxIYzWZ8ezyQUehh7GGThTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785494; c=relaxed/simple;
	bh=VQvTHaKjq2IppELUeGZ27cXftHjb7rM3AHyhxYuyKog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re1aSD5U06Bgv4qQ1Frnjv2gK38WrVe5LXbLpfk41MUnU0ux0E6GGDlRdWyr4oZu4ZfXzpK9dU1t0TfWAVC4C9jnJLvkCoTw+uPsi9Y3zO+a4S7SpSNSVwQLNtspLsDM8mulw0b0atx9Mip4/qJ33vjqpw5fREYNRSqnYL3D93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgJWt9uH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgJWt9uH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D99C4CEF7;
	Fri,  6 Mar 2026 08:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772785493;
	bh=VQvTHaKjq2IppELUeGZ27cXftHjb7rM3AHyhxYuyKog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgJWt9uHAKANLW7QCNYbftk96eUhWeqvtb4yjngyu5r5yL9WUiWVhCCjtpvn5yNlW
	 yTiFO7avB26gcvnbK1MOMxBCZ79DMNIqjuc6xOE0Dz7KV3JQchnrKwUwbiT75by4+7
	 goN/VhKwKYEPAoqgMun3suhqVxw2L/v/A2EKMOWEKLq1ti3w8SyD+TDp7D0sERe52Q
	 poGb/ekUXsp8WLGOwX3espSH28PqJX1qqbJIhM2JZeAfQRVH/C6nhJKfRRWwf4V+09
	 RdK46/fwFcsQrwVpKGNKoS6v13O48g4sHAjYhOapZTAIaQBtZeNo0BCeyoDeaEcWBa
	 klfyDJonjQDTQ==
Date: Fri, 6 Mar 2026 09:24:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc
 timeouts
Message-ID: <aaqPUj7UNc1uFcnm@ryzen>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-2-dlemoal@kernel.org>
 <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
 <8011c682-7fc6-4cab-b142-d05fd3b09de0@kernel.org>
 <68df8235-dc05-41e2-afdd-42f7143e26ec@roeck-us.net>
 <68325544-334d-45d6-b406-82cc1379df0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68325544-334d-45d6-b406-82cc1379df0e@kernel.org>

On Fri, Mar 06, 2026 at 09:50:49AM +0900, Damien Le Moal wrote:
> > 
> > I can try, but if the AI analysis is missing the point I don't really know
> > how to describe/explain it. Can you give me some guidance ?
> 
> I think the AI is correct. That "if" without the index check can lead to false
> positives and we can endup timeout-failing a deferred qc that has not timed out yet.

Which is exactly what I wrote yesterday:

>> However, if there was a timeout of a command, which was not the deferred QC,
>> but the deferred QC did not timeout, I think it is wrong to complete the
>> deferred QC as a failed command.
>>
>> So... I actually think that the change suggested by the AI is something we
>> want.

Glad that you came to the same conclusion after some coffee :)

(Yes, I did actually look at ata_qc_for_each_raw() before writing my reply
yesterday.)


Kind regards,
Niklas
