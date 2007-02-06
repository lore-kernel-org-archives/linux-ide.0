From: Tejun Heo <htejun@gmail.com>
Subject: Re: Serious bug in sata_sil module in 2.6.19.2?
Date: Tue, 06 Feb 2007 15:30:09 +0900
Message-ID: <45C82071.5080808@gmail.com>
References: <45C1BFE0.4080004@effenberger.org> <45C1FBFF.3050706@gmail.com> <45C27A4D.8070802@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:31835 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823AbXBFGaS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 01:30:18 -0500
Received: by py-out-1112.google.com with SMTP id a29so923873pyi
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 22:30:17 -0800 (PST)
In-Reply-To: <45C27A4D.8070802@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Florian Effenberger wrote:
> Hi there,
> 
>> sata_sil hasn't seen as much change as other drivers and is one of
>> the more stable ones.  I'm definitely interested.  Please post the
>> pics.  If the video contains useful info, can you host it somewhere?
> 
> I've uploaded the image at
> 
> http://img482.imageshack.us/img482/6677/img0149rh5.jpg
> 
> and the video at
> 
> http://video.google.de/videoplay?docid=-3785898339758585695
> 
> Can anyone detect something on the images?
> 
> (If you reply, please put me in Cc, I am not subscribed to the list.
> Thanks!)

That definitely looks like libata error messages but can't tell anything
other than that from it.  It could be cause of system hang and the weird
screen or just another symptom of another problem.

Is it possible for you to connect a serial console or configure
netconsole (Documentation/networking/netconsole.txt) such that the
messages are preserved after such hang occurs?  Also, please turn on
PRINTK_TIME (Kernel Hacking -> Show timing information on printks) so
that we can tell what happens when.  To make the info more useful, you
can log into the machine from another machine and run something like
"while true; do sleep 1; date; done" on it such that you can tel exactly
when the machine went down.

Thanks.

-- 
tejun
