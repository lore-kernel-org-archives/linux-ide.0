Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA7A24A7C4;
	Wed, 15 Jan 2025 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951015; cv=none; b=iDx2XHW0bbHoKIWE5zQPKFOV15Fm4mZqS9JhOKNugBs+tdNIOGu8FsCTy/o2UXp3GqPHws7r08p8MV/AEXby0p+X0OKpyJRPO4Z1emNx1baWxaL3CloCPTZ2D0cJQo9xLY3PvtQ7TJWA6f0sHX+76zhDyBzeF8pAqn0CFwU0cjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951015; c=relaxed/simple;
	bh=q4W2Kck2O2YAKdfwQHwHZnkuzzxW2hE7DYKNQQM0EQ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BuFzzaJKhBfatEkTUSl0044N6c1ovzDLb7Sg8+ZgXH09hrqAzxZ8RMo+JDcFZ7kxRdCz8y10EH2hm62S5zr2TUuV8Q3oyH3moZC3dS9yEsW5/spN9xxVpASEjdQ48SZFMZDTismaVizvIPRMJMnf08RdiyV/xTqAVdV3MVzSELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlaKFewz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlaKFewz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FB0C4CED1;
	Wed, 15 Jan 2025 14:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736951014;
	bh=q4W2Kck2O2YAKdfwQHwHZnkuzzxW2hE7DYKNQQM0EQ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hlaKFewz5YWt0G1rm80K2FBZX9Q/EQY362et1lYsiHiKc/oBgpeV/ozM0HAF9BVAy
	 sq5RHYB+bb65r5KY1kc7vNBbwHmiDTyibsA2NONMGnzxD3xMVygmiVj9pEjgJeI/aq
	 Gc5q79i+cgY6dlkxESzT1kOSCKf4ECwm3K7jfIE7rG8SMhYozKewN9FLZADc6c4Sct
	 VhyriyRoV9WJ2a5+6TNAGxMul/FD3DkuJ9CDm9homOlHw45VjwajFky5H3MJZSklTV
	 0cfj1rBBZzZMFOB0Y/Mxa5u9/MpvfWmZZcBarDv8gElgG0wc7wLiaXsJB0bPlThvWb
	 4Pe0GBaTLZqjQ==
From: Niklas Cassel <cassel@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250109175427.64384-1-rgallaispou@gmail.com>
References: <20250109175427.64384-1-rgallaispou@gmail.com>
Subject: Re: [PATCH v2] ahci: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Message-Id: <173695101333.1849743.15943905169390341632.b4-ty@kernel.org>
Date: Wed, 15 Jan 2025 15:23:33 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 09 Jan 2025 18:54:27 +0100, Raphael Gallais-Pou wrote:
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
> 
> 

Applied to libata/linux.git (for-6.14), thanks!

[1/1] ahci: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      https://git.kernel.org/libata/linux/c/f2809aa4

Kind regards,
Niklas

