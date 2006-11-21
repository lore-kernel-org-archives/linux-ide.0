From: Arnaud Patard <apatard@mandriva.com>
Subject: Re: [PATCH] pata_marvell: fix cable detection - take 2
Date: Tue, 21 Nov 2006 11:28:55 +0100
Message-ID: <m3d57hccuw.fsf@anduin.mandriva.com>
References: <m3psbhdg4j.fsf@anduin.mandriva.com>
	<20061120204218.GC24922@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:24842 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1030771AbWKUK0U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 05:26:20 -0500
In-Reply-To: <20061120204218.GC24922@devserv.devel.redhat.com> (Alan Cox's
	message of "Mon, 20 Nov 2006 15:42:18 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> On Mon, Nov 20, 2006 at 09:20:44PM +0100, Arnaud Patard wrote:
>> 
>> Last time I looked at the cable detection code, I fixed the "always
>> detect cable as sata cable" case, but this is not enough. I didn't
>> notice that the 80-pin cable was seen as a 40-pin cable.
>> The appended patch fixes that.
>
> Thanks - the docs were a bit blank on which was which - have you checked
> this now detects right both ways around ?

yeah, I've tested on two boxes, with 40-pin and 80-pin cables :)


