Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488827462;
	Fri,  7 Nov 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505130; cv=none; b=B3ZNs/A4UKoDb4xgq125ELLYj55nh3Sy/XFuKVl09318fUtwvzymMXH1GYMy+ChOibrnUrowHWRo24BhXwSGMDIdW33/qzdd6GDpiAMxNwQC65P6fhfOkYaotkQFqS9wHbWeLw7PzujRpYdcwuJngX50byCz9ngRguTlMQHET4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505130; c=relaxed/simple;
	bh=ENvjq7F3dQB96OZQww5CqJrGO1JxGUPY5vCkPTonfPQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ScAZPCzxDqmJZSqc/1WUH8EG2sI5S459gO5hbV7WwfET7fp6cFu47Dj63c4Ryg7Cf8YvuXoCuv+DjNMZopUIM8njGCTpZ7Svx1v4D/u+XLxBf4K1sAhJpAEJHlyLtVmHSLGpxm6mfgQGQpF63ZzmnGAFUBXNCij+ZtwGGvsyzpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSiWgOMC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSiWgOMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6261DC116B1;
	Fri,  7 Nov 2025 08:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762505130;
	bh=ENvjq7F3dQB96OZQww5CqJrGO1JxGUPY5vCkPTonfPQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BSiWgOMChA/kpu7XYaGEsSG2hqwsHmvA96u2bTDNkLgvVlFSv07CwN4lcu1qBBT6z
	 BN4xwIwTD2QRQ9fu+PtrsxqApQiSu7IADK3c1NZruXbEWKowKfL0bh9hhC8oB4xOLa
	 oVfAU4PscYY32rVkoLzz61t+WFxLXoUV5nWaGPgIGD7PCa7XvUojdQbvotayqbQMKn
	 c/CQHwxZV5GyQWSaKhl32+0ymagBEaoFu+DnkNztCcGRlx3HIGL6e7T+EgGCvyxtUi
	 wPy3hIUE33la9uZu2qqHa3NDedE+mbzbaHvCdfws+SgZTVR7GWo0OKknpKwWkZ05ED
	 LOarYIskKPQBQ==
From: Niklas Cassel <cassel@kernel.org>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20251106160813.314932-1-marco.crivellari@suse.com>
References: <20251106160813.314932-1-marco.crivellari@suse.com>
Subject: Re: [PATCH] ata: libata-sff: add WQ_PERCPU to alloc_workqueue
 users
Message-Id: <176250512811.632228.18184423075799177449.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 09:45:28 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 06 Nov 2025 17:08:13 +0100, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> [...]

Applied to libata/linux.git (for-6.19), thanks!

[1/1] ata: libata-sff: add WQ_PERCPU to alloc_workqueue users
      https://git.kernel.org/libata/linux/c/13f4d995

Kind regards,
Niklas

