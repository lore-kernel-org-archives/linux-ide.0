From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: Remove inline attribute from ata_sff_host_intr()
Date: Mon, 24 Nov 2008 14:20:39 +0900
Message-ID: <492A39A7.4080703@kernel.org>
References: <49260327.8050408@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39756 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbYKXFUt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Nov 2008 00:20:49 -0500
In-Reply-To: <49260327.8050408@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-ide@vger.kernel.org

David Daney wrote:
> ata: Remove inline attribute from ata_sff_host_intr()
> 
> ata_sff_host_intr is a public function, it should not be declared inline.

Why not?

-- 
tejun
