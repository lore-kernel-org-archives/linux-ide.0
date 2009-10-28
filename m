From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Enable SB600 64bit DMA on MSI K9A2 Platinum
Date: Wed, 28 Oct 2009 13:14:33 +0100
Message-ID: <4AE835A9.40806@kernel.org>
References: <65a6ef750910252203s58af446fv268c857191e698d3@mail.gmail.com>	 <4AE5A330.3080506@kernel.org>	 <65a6ef750910261605q45a08791h53cc2afd5d006bb3@mail.gmail.com>	 <4AE7382F.20302@kernel.org>	 <65a6ef750910271551i47858982xd1138e4a70a1b076@mail.gmail.com> <65a6ef750910280449k5597d3abkc0995080954e5760@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35327 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873AbZJ1MNn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Oct 2009 08:13:43 -0400
In-Reply-To: <65a6ef750910280449k5597d3abkc0995080954e5760@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Mark Nelson wrote:
> Things look promising so far with lots of DMAs above 4GB (snippets
> from syslog):

It's probably working okay but a good test would be to repeat to copy
a large file and checksum it and verify checksums actually match.

Thanks.

-- 
tejun
