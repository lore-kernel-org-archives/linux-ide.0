From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCHSET #upstream-fixes] git tree available
Date: Mon, 19 May 2008 22:58:23 -0400
Message-ID: <48323E4F.3050806@rtr.ca>
References: <12111273141039-git-send-email-htejun@gmail.com> <48305961.2050509@gmail.com> <006501c8ba19$c1f53340$6917a8c0@parents>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1098 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754451AbYETC62 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 May 2008 22:58:28 -0400
In-Reply-To: <006501c8ba19$c1f53340$6917a8c0@parents>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian & Chamaigne Scamman <scammanbc@earthlink.net>
Cc: 'Tejun Heo' <htejun@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org

Brian & Chamaigne Scamman wrote:
> Tejun-
> 
> The hotplug fixes didn't solve the problem. After adding some "logic
> monitoring" statements, I found that the successful discovery of the drives
> depends on the response from sil24_exec_polled_cmd.
> 
> If the call from ata_wait_register is 327680, the drives are recognized; if
> the response is 262144 the drives have timed out.
> 
> I've also noticed that the drives respond to the EH entering with DevExch
> vs. PHY RDY changed.
> 
> Bottom line, the drives seem to be recognized almost every time I attach
> them to the PMP after the EH has completed processing the empty PMP.  If the
> drives are attached to the PMP before the PMP is attached to the controller,
> the drives are almost never recognized (EH times out).
..

hp-polling is beginning to look better and better..  again.  :)
