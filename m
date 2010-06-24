From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libahci: Fix bug in storing EM messages
Date: Thu, 24 Jun 2010 10:30:30 +0200
Message-ID: <4C2317A6.6000606@kernel.org>
References: <1277350463.8158.3.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33030 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468Ab0FXIbz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jun 2010 04:31:55 -0400
In-Reply-To: <1277350463.8158.3.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harry Zhang <harry.zhang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, shane.Huang@amd.com

On 06/24/2010 05:34 AM, Harry Zhang wrote:
> In function ahci_store_em_buffer(), if the input (signed char*) buffer
> contains negative data, the constructed 32-bit long message data may
> be wrong.

Explaining why it was wrong would be nice.  Also is adding a comment
explaining why the uchar pointer is needed.  Nothing fancy, just simple
/* avoid sign extension */ should do.

Other than that, Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
