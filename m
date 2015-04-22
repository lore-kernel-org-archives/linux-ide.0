From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] libata: Change medium_power LPM policy to match
 Intel recommendations
Date: Wed, 22 Apr 2015 10:51:57 -0400
Message-ID: <20150422145157.GB10592@htj.duckdns.org>
References: <1429370796-5881-1-git-send-email-mjg59@coreos.com>
 <1429370796-5881-4-git-send-email-mjg59@coreos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36392 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932874AbbDVOwB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Apr 2015 10:52:01 -0400
Content-Disposition: inline
In-Reply-To: <1429370796-5881-4-git-send-email-mjg59@coreos.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@coreos.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kristen@linux.intel.com

On Sat, Apr 18, 2015 at 08:26:36AM -0700, Matthew Garrett wrote:
> Intel publish a document on designing energy efficient SATA devices at
> http://www.intel.com/content/dam/doc/reference-guide/sata-devices-implementation-recommendations.pdf
> which recommends that ALPE be set, ASPE be cleared and that DIPM be enabled
> on the device. Right now we have no policy that matches that - medium_power
> does not enable DIPM and min_power sets ASPE. Change medium_power to
> implement these recommendations, with the addition of devslp state being
> inherited from the initial configuration. With luck this will provide
> reasonable power savings without causing the device breakages we
> occasionally see with the min_power policy.

Can we add comment explaining what med_power implements and link to
the above?

Thanks.

-- 
tejun
