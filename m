Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6274202F96;
	Mon,  3 Feb 2025 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738584738; cv=none; b=ow1z+RvQFTfYApOVtk+H75Eh4dZdncMuOoYYXdoYrCyq5ZKs54wXQVSDypnudnRa8J+2HI3uw1CipfRHeXwKnIBoEGuLte5WY2zW6kwPUnxv7pHhLdemtqET1OzVbHO/x1CcFshj8W3HafgWgrvEn3nfdY8VmGyOeLBc3BZgQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738584738; c=relaxed/simple;
	bh=d2GaN60of87m3ShwMqoxdC02HZxqg5gZFUb7HCm/wQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yo8nbSmgnOaoKLf1f5ehucBrX/UDXMLti7+8Yw5NLR3fnxp0GPnVRgUTGSMvfjdJmF/h84VFwX1/kAlXcbVJpNEMxyuAkji9Spmd+rcXXXVMyQ6YFcAPcK8NVFn+SJEl5xm1aM2lZOguBt9QnU9h+W9wu/y7FkDMQGm7agqDxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfiX/HIW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfiX/HIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AC8C4CED2;
	Mon,  3 Feb 2025 12:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738584738;
	bh=d2GaN60of87m3ShwMqoxdC02HZxqg5gZFUb7HCm/wQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mfiX/HIWLrmS+W3rsWsA5etOhmlLnahyryHTiQH6vj9tnvVAshESwS/RLtiL/vqZv
	 cDuG3VkvVjtQQ26k1BpYkoHPufFH24klFCMhsv8PuSfRuuN8wMVicB1P+Br28j5js3
	 o+1vPvUCpUrBkAr68MAK1L1ZvhNxEu3/nSUffA54aUcviJ+qmGZnNYbMHe8EvpjiAb
	 /hLiHpY1JSv9chFz279ky3+DkixZK16C8IDkA8X+drSV9crFQglDKwqhCHLgiPV2gM
	 J8rxYoYC+NM7X7RWGiDn5giUD+2kcf8JhDMfZwxf1dVMY3Zg4el0mpo8gtbo0HnuwG
	 xgIVegTixNQwg==
From: Niklas Cassel <cassel@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Christian Heusel <christian@heusel.eu>, linux-doc@vger.kernel.org, 
 linux-ide@vger.kernel.org
In-Reply-To: <20250130133544.219297-3-cassel@kernel.org>
References: <20250130133544.219297-3-cassel@kernel.org>
Subject: Re: [PATCH 0/1] Add 'external' to the libata.force kernel
 parameter
Message-Id: <173858473657.30534.17812766236080089156.b4-ty@kernel.org>
Date: Mon, 03 Feb 2025 13:12:16 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 30 Jan 2025 14:35:45 +0100, Niklas Cassel wrote:
> This patch replaces an earlier patch proposal, which added an
> 'external_port_map' kernel module parameter to the ahci driver:
> https://lore.kernel.org/linux-ide/20250116143630.1935474-4-cassel@kernel.org/
> 
> 
> This patch instead adds support for 'external' to the existing libata.force
> kernel parameter.
> 
> [...]

Applied to libata/linux.git (for-6.15), thanks!

[1/1] ata: libata-core: Add 'external' to the libata.force kernel parameter
      https://git.kernel.org/libata/linux/c/deca4232

Kind regards,
Niklas

