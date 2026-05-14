Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD8625
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724803; cv=none; b=acYffdLX7DKssioTN/WPKBwzUCCAqMha25SQRueAXf2V+lz3rjpv2b+/i5Xom02yV3HsI257XKsSly8Ned6ySB4O51zganrZp0voPtUofmVKkmbm8n9QvF+bPMUU0UtaWdtkypxuw/9A6QDIVJtQiakhJhnRFxNm5IqwO5IiAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724803; c=relaxed/simple;
	bh=8zGE/ZpHQOAfsV4LresRvnn/yri2uh67J608wB+qw4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHS4QyCbWilRkCTcuH+5S14cIuatZIyyNy3MYMp4zLp9dysbvL773DtaJ3U9A7znQXcl1ImRvF+7mnbQNZzFeRFFUQ3fnOK9Joa1V6s9dF0OEaAJlt/Hins27Txrq5ihKW14nYu0WW1Y3RrwbKmSRfkZRGwWZNlyZZc2jbcJ2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3xUQeLm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3xUQeLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E7BC19425;
	Thu, 14 May 2026 02:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724803;
	bh=8zGE/ZpHQOAfsV4LresRvnn/yri2uh67J608wB+qw4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G3xUQeLm7iAUO4621Nr0tUaU10PnGGJgeMKzlRr84H9IgCstqYnk0+ISWZdbclqFX
	 +SFj/P0yXBucUV9XyrUZ2lC7LfM8W5vYGuNAkfwKRfwxvPkY/7DkNtjAz+s7zjnMf4
	 A25xFaKLSi87cL44I2d4BdZmTkWjcr12zqnNctsQbUruijl5pRmPs55s+a9LWtltzn
	 Rk12eC9Yj7Hxn5JMbeGLzfbCUC/38mLS2G0l9Q1rfmVdmlIJDBsfw3eEE13uq8g25G
	 HMZonSew97WuPPeq4kTxP+pvKbHGRm7pA+WImaqXqRXwMxvhJsXI/p4s9qcylaZPXu
	 99e/P3su9nnLQ==
Message-ID: <7e452d99-0208-4eca-a340-f72814ee30d2@kernel.org>
Date: Thu, 14 May 2026 11:13:14 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-eh: queue hotplug work on the
 system_dfl_long_wq workqueue
To: Niklas Cassel <cassel@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Marco Crivellari <marco.crivellari@suse.com>, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, linux-ide@vger.kernel.org
References: <20260513081001.714630-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260513081001.714630-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 5:10 PM, Niklas Cassel wrote:
> ata_scsi_port_error_handler() uses schedule_delayed_work() to queue
> the ap->hotplug_task work.
> 
> schedule_delayed_work() always uses the system_percpu_wq per-cpu
> workqueue.
> 
> ata_scsi_scan_host() queues the ap->hotplug_task work on the unbound
> system_dfl_long_wq workqueue.
> 
> It seems counter-intuitive to queue the same work on two different
> workqueues. Thus, change ata_scsi_port_error_handler() to also queue
> the ap->hotplug_task work on the system_dfl_long_wq workqueue, such
> that the work is always queued on the same workqueue.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
