From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/06] sata_mv: cache frequently read registers
Date: Wed, 25 Feb 2009 15:20:56 -0500
Message-ID: <49A5A828.1090300@pobox.com>
References: <4994FF3D.90904@rtr.ca> <499A029A.1060101@pobox.com> <499A26B8.7070107@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59804 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756673AbZBYUVB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 15:21:01 -0500
In-Reply-To: <499A26B8.7070107@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
> ..
>> ACK patches 1-6
>>
>> however, they do not seem to apply to libata-dev.git#upstream, which 
>> already has several sata_mv changes in it.
>>
>> Can you regenerate please?  No need to copy the list on resend, unless 
>> the patch content changes....
> ..
> 
> Mmm.. strange.  Here (attached) are the six patches again,
> along with what my git here gives for the upstream copy of sata_mv.c
> from *before* applying the patches.

Sorry for the delay... the attachments applied and worked just fine.

I eyeballed the first patch and it looked the same as your emailed first 
patch, so I'm guessing there was an email bugaboo somewhere, rather than 
a patch content problem.

Applied all 6 to #upstream.

	Jeff



