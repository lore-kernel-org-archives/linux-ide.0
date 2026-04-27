Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F72701CB;
	Mon, 27 Apr 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282826; cv=none; b=f93s8K/fcIsnqkTJmWRYS6Ta9CqQo51aI3MXboFdice5gBYojRxbPEj1Xaf8qwA5MxDsLfAFnUY2Eb5OL8PfIbduOPQBZD+muOk5SU/Ex/+loH9Q9qU+XHiikjtf9ocDg/FNPUi/vhATQdO12LK+L7ZVpf73VYdXiVSo3fa3VyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282826; c=relaxed/simple;
	bh=mpjnMhpYQ/4YNLFbIh+lqBH3wGCjmtK1JasmVSVfm8o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ugp6X6xMBYiEKOuxMLwjF8tICqhKFmo/NzWCmn88IpwD3hznh3f+kkF7tyVXf1bk6/RnBymcDP6eyitFlsreqAMHQDy3jNyJx7Qg0aZ+t08Sx/wdyGX4Cz+Ki1YdJ9WfPvorJp+9LDmsRAsJbTiwVhPrhjKelmAcPy/EzjggzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY2AQEhj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY2AQEhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CEBC2BCB6;
	Mon, 27 Apr 2026 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777282825;
	bh=mpjnMhpYQ/4YNLFbIh+lqBH3wGCjmtK1JasmVSVfm8o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fY2AQEhj4lFDNPWPcSgXgPrniEi1c7ljAeUMvowK7lUGB5gCdeLnfSDMQt20iv+wi
	 FY3oXGhrnPeWaPTwRbD5w9tFb2fEYds0ftqIol29zUBNnmIVxi9nVJ4oLT+IcbpA4l
	 ngUmTzx0XW6VoZCH+tD55pGxmvKKn63APSKI3vMOGoYtYFvP6Zri/wUUfywwW7o4o9
	 bza3zJDqLNdetAbpOp1evG6aj9t1wOuakq6IEiFiqr6CezPXM3fph3u0lbrBI9Y3r7
	 OyVoLD7xnwv6SrE6yiuszzkxCoCrsFiBqe4I5XFQzi2yOlAOo3JDx99TDyO+6HScqY
	 pwcYN67+dOvcg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260424103830.2616828-1-johan@kernel.org>
References: <20260424103830.2616828-1-johan@kernel.org>
Subject: Re: [PATCH] ata: pata_parport: switch to dynamic root device
Message-Id: <177728282459.2013659.16161609914156129933.b4-ty@b4>
Date: Mon, 27 Apr 2026 11:40:24 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 24 Apr 2026 12:38:30 +0200, Johan Hovold wrote:
> Driver core expects devices to be dynamically allocated and will, for
> example, complain loudly when no release function has been provided.
> 
> Use root_device_register() to allocate and register the root device
> instead of open coding using a static device.
> 
> Note that this also fixes a reference leak in the unlikely event that
> device_register() ever fails.
> 
> [...]

Applied to libata/linux.git (for-7.1-fixes), thanks!

[1/1] ata: pata_parport: switch to dynamic root device
      https://git.kernel.org/libata/linux/c/163f6494

Kind regards,
Niklas

