From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2 v2] ahci: EM message type auto detect
Date: Fri, 23 Apr 2010 11:52:01 +0200
Message-ID: <4BD16DC1.1070705@kernel.org>
References: <1272014839.3594.41.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58749 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755745Ab0DWJw5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Apr 2010 05:52:57 -0400
In-Reply-To: <1272014839.3594.41.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harry Zhang <harry.zhang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, shane.huang@amd.com

On 04/23/2010 11:27 AM, Harry Zhang wrote:
> To detect enclosure management message type automatically at driver
> initialization, instead of using module parameter "ahci_em_messages".
> 
> Signed-off-by: Harry Zhang <harry.zhang@amd.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
