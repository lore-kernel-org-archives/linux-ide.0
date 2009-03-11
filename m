From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Keep shadow last_ctl up to date during resets
Date: Wed, 11 Mar 2009 16:42:57 +0900
Message-ID: <49B76B81.9000407@kernel.org>
References: <49B65125.7030201@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32790 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbZCKHmf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 03:42:35 -0400
In-Reply-To: <49B65125.7030201@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stuart MENEFY <stuart.menefy@st.com>
Cc: linux-ide@vger.kernel.org

Hello,

Stuart MENEFY wrote:
> libata keeps a shadow copy of the ATA CTL register (which is write only),
> and only writes to the hardware when the required value doesn't match
> the shadow. However this copy wasn't being maintained when performing
> reset functions. This could cause problems for the first operation after
> a reset when the correct value might not be written to the CTL register.
> 
> This problem was observed when hotplugging a drive: the identify command
> was being issued with interrupts enabled, when they should have been
> disabled.
> 
> Signed-off-by: Stuart Menefy <stuart.menefy@st.com>

Nice catch.  Maybe a nice addition would be a ata_sff_write_to_ctl()
or something which always does the right thing.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
