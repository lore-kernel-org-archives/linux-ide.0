From: Tejun Heo <tj@kernel.org>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Thu, 09 Apr 2009 06:48:06 -0700
Message-ID: <49DDFC96.7090305@kernel.org>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>	<49DDEF02.7090004@garzik.org>	<20090409135323.5b2bed4b@lxorguk.ukuu.org.uk>	<49DDF33E.6000102@garzik.org>	<20090409141254.283d9f11@lxorguk.ukuu.org.uk>	<49DDF920.70801@garzik.org> <20090409144110.34654dd9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35505 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585AbZDINsl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 09:48:41 -0400
In-Reply-To: <20090409144110.34654dd9@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> Thus 'set' has always been an illusion for libata.  It's really been 
>> read-only.
> 
> Which nicely solves the flags2 problem - we have flags, and we have
> dynamic flags and if we move the other changing flags into dynflags over
> time all will be happy.

Umm... there's already ap->pflags for the purpose and it was splitted
out for exactly the same reason.  If we're running out of flags space,
I think we better switch to bitfields than introducing flagsN and
risking testing/setting the wrong flag to the wrong field.

Thanks.

-- 
tejun
