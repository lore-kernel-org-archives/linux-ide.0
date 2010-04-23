From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2 v5] ahci: add "em_buffer" attribute for AHCI hosts
Date: Fri, 23 Apr 2010 11:52:16 +0200
Message-ID: <4BD16DD0.2090900@kernel.org>
References: <1272014918.3594.43.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58748 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755647Ab0DWJw4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Apr 2010 05:52:56 -0400
In-Reply-To: <1272014918.3594.43.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harry Zhang <harry.zhang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, shane.huang@amd.com

On 04/23/2010 11:28 AM, Harry Zhang wrote:
> Add "em_buffer" attribute for SATA AHCI hosts to provide a way for
> userland to access AHCI EM (enclosure management) buffer directly if the
> host supports EM.
> 
> AHCI driver should support SGPIO EM messages. However the SATA/AHCI
> specs did not define the SGPIO message format filled in EM buffer.
> Different HW vendors may have different definitions. The mainly purpose
> of this attribute is to solve this issue by allowing HW vendors to
> provide userland drivers and tools for their SGPIO initiators.
> 
> Signed-off-by: Harry Zhang <harry.zhang@amd.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
