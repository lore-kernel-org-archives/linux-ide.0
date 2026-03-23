Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAEC35F19B
	for <linux-ide@vger.kernel.org>; Mon, 23 Mar 2026 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263941; cv=none; b=EgLNdS8gzgwQyUAbMSXW+0gwhHCqhb4QCopa0YQ8C/dWcExL2+MWuA4nOhEEerpc/EubVXqlwEixsPw+yBKPEzR1vc0SMJzdGQVRsU4h1Ca6RBjre8QNO1CLmbmGJh27Mg+g8VGo7KvP/UF7i4Wug4hwvqrbOMeqPVg2MCNDvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263941; c=relaxed/simple;
	bh=3bWvevXvflzzX7pmSsx5iYA1OzwGm8/M6SyRFISBuJQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vs01xjsNN8FgJnqWAhwCcn14MVP1+84ZTO6Wafoo8cZTij9tR2y/5PxmJTylf+SZgmHLg5aY7hGrH3n7TtsL9xLirD5V6iTTn1J7cITQn7SmxQ0psCr8AIzrfsv/uvu5jdGozKPdjtwpDU3hJiUtsWIlxcqaMTtyVtPSouguGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCPRwxQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCPRwxQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101A4C4CEF7;
	Mon, 23 Mar 2026 11:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263940;
	bh=3bWvevXvflzzX7pmSsx5iYA1OzwGm8/M6SyRFISBuJQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pCPRwxQJyQ4AT9bpyJ1ckwC0fOkoSmZn8AFNwMGHLa8WnXh1gYZSY3x/Oc1Hji6rn
	 Xd8LB7Y25EtJKbJgZGWY33g20/bQ+uPAu5pT3E6DEgGWQjG7WlukKBU5nfYvyZE02a
	 oTc9X6Jk7xF7hpl+pemDm1KIcMdUHz9Um9d97dakusttmvhBtAqGgmuuhapSWZ1C4Y
	 6vaATRy/JRSxuuQ3FW2eMxJ32oH3OacauC5cKfIM0BuSBWMFGk3a7l1ZDFnMEfnM+o
	 2m3K+NuEt0I8mXm+SHb8m5MDUUfi7KM5s01NXtG4QRPOBGItE9SUJrK2v4BoyOKmEy
	 Sd3F4iqRRrCtw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-ide@vger.kernel.org
In-Reply-To: <44265829-58c8-41ad-b202-e5488892af26@gmail.com>
References: <44265829-58c8-41ad-b202-e5488892af26@gmail.com>
Subject: Re: [PATCH] ata: libata-transport: remove redundant dynamic sysfs
 attributes
Message-Id: <177426393979.622776.3602878643683233676.b4-ty@kernel.org>
Date: Mon, 23 Mar 2026 12:05:39 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 20 Mar 2026 23:10:59 +0100, Heiner Kallweit wrote:
> Use the static sysfs attributes directly, this allows to significantly
> simplify the code. See attribute_container_add_attrs() for why member
> grp can be used instead of attrs.
> 
> 

Applied to libata/linux.git (for-7.1), thanks!

[1/1] ata: libata-transport: remove redundant dynamic sysfs attributes
      https://git.kernel.org/libata/linux/c/78ec0699

Kind regards,
Niklas

