From: Tejun Heo <tj@kernel.org>
Subject: Re: reenabling disabled ata links from the command line
Date: Mon, 14 Jun 2010 09:36:41 +0200
Message-ID: <4C15DC09.2010900@kernel.org>
References: <20100613090600.GA31086@basil.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46135 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741Ab0FNHgv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jun 2010 03:36:51 -0400
In-Reply-To: <20100613090600.GA31086@basil.fritz.box>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-ide@vger.kernel.org

On 06/13/2010 11:06 AM, Andi Kleen wrote:
> So I was wondering is there a way to reenable a link that has been
> disabled to try again?
> 
> I presume a module reload would do it, but that's not practical when your
> root fs is on another SATA port.
> 
> Should something like this be implemented?

echo "- - -" > /sys/class/scsi_host/hostN/scan

-- 
tejun
