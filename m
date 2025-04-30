Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E51EEF9;
	Wed, 30 Apr 2025 06:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745994917; cv=none; b=BJaZQ+VwhCNJIOvOhIXCFdqCnz1EH3Ir/cwwKGdux55kl59nXjkfKqpiI1NCZ9VDamU0q3IsG66wDvhWjp8Gw+pmtsomF1miwsOjRqeZbNRkdDtrE8ZZqnXA+tVbORbG1msvNQSygyD/fyQqyIzq1B4GOZJaHnK7XKUZLIGAVlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745994917; c=relaxed/simple;
	bh=R0EzpLjoRCY0UKjIKj/B4YO03H+hveYLXF2IY8J5jes=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qqe1hhm8c/OA9FQqNwWEnbJ6ugLt+bv/zka9uuQlJZTn7hZwfMkQ+4bGL5YBiFuifDtFtZEvepNY+yPWQBhSWy9DQHXPvAc3onuB5Md1HKK/5iu8NPUsyZx+ELItEipNALq39li/M4O9qd2vtkZGmUBtpAvzi4Gc6tsS4sbcUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baf3zwOt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baf3zwOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA637C4CEE9;
	Wed, 30 Apr 2025 06:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745994915;
	bh=R0EzpLjoRCY0UKjIKj/B4YO03H+hveYLXF2IY8J5jes=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=baf3zwOt1kmYSyB09vMY/s4cup7zaGV4+KBOZ7wx1PCSFPuxF7dCL4Cq+BGthzGMn
	 iMWGaDz7xxF0d6DgwoHWsx4SnV3AEdbgZsjt9BMjAFGfDqnyYgnJX13Jo5E38pUkXt
	 nFvzOnqdHdOj2WbfQMSkW8GcsQBXZb1hPaDSY9DZ+u1u8K25jN8SRjRlmZkuT/tGGw
	 ee7/2d5apylN6rpOTi8wWW5XfHSxPhmbA12sqcfpq/7BuZRrUoTWHqysBYvs3It8Ip
	 0iYHCSapTdoeHx85O/E5TTdt+y6dGErEgia7v2T0HgDQdkT2bfP/TXVVr1WVlyBjRF
	 5Ota7gypV8I0Q==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Damien Le Moal <dlemoal@kernel.org>, Mikko Korhonen <mjkorhon@gmail.com>
In-Reply-To: <20250429164610.68746-1-mjkorhon@gmail.com>
References: <20250429164610.68746-1-mjkorhon@gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-Id: <174599491460.1423052.1166861891633519770.b4-ty@kernel.org>
Date: Wed, 30 Apr 2025 08:35:14 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 29 Apr 2025 19:44:35 +0300, Mikko Korhonen wrote:
> Make WDC WD20EFAX-68FB5N0 hard drives work again after regression in
> 6.9.0 when LPM was enabled, so disable it for this model.
> 
> 

Applied to libata/linux.git (for-6.15-fixes), thanks!

[1/1] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
      https://git.kernel.org/libata/linux/c/f847305c

Kind regards,
Niklas

