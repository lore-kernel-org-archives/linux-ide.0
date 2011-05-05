From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch v3 1/3] block: add a non-queueable flush flag
Date: Thu, 5 May 2011 09:53:58 +0200
Message-ID: <20110505075358.GA30950@htj.dyndns.org>
References: <20110505015932.306763905@sli10-conroe.sh.intel.com>
 <20110505020417.586891398@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59443 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1EEHyD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 May 2011 03:54:03 -0400
Content-Disposition: inline
In-Reply-To: <20110505020417.586891398@sli10-conroe.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shaohua.li@intel.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jaxboe@fusionio.com, hch@infradead.org, jgarzik@pobox.com, djwong@us.ibm.com, sshtylyov@mvista.com

On Thu, May 05, 2011 at 09:59:33AM +0800, shaohua.li@intel.com wrote:
> flush request isn't queueable in some drives. Add a flag to let driver
> notify block layer about this. We can optimize flush performance with the
> knowledge.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
