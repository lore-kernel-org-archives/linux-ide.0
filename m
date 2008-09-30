From: Tejun Heo <tj@kernel.org>
Subject: Re: Frequent head unload cycle - WD1600BEVE
Date: Wed, 01 Oct 2008 02:35:33 +0900
Message-ID: <48E26365.5010905@kernel.org>
References: <f56b605d0808060701p571c4695w85987d444fc16eb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34561 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759AbYI3Rgy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Sep 2008 13:36:54 -0400
In-Reply-To: <f56b605d0808060701p571c4695w85987d444fc16eb9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carlos Bessa <carlos.bessa@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello, Carlos.

Carlos Bessa wrote:
> Hi,
> I have installed a new hard drive to my laptop and noticed i have this
> problem. Didn't have any problem with the previous/original drive.
> 
> Laptop: Targa Traveller 826T (clone of MSI M635 - MS1029)
> Hard Drive: Western Digital 2.5" WD1600BEVE
> OS: OpenSuSE 11.0 64bit
> 
> Western Digital has an utility on their website to resolve this, but
> it does nothing as it notifies that the hard drive already has the
> latest firmware:
> http://wdc.custhelp.com/cgi-bin/wdc.cfg/php/enduser/popup_adp.php?p_sid=undefined&p_lva=undefined&p_li=undefined&p_faqid=1414&p_created=1138984716&p_sp=undefined
> 
> I have noticed this problem for a while now, and have used this
> information and laptop-mode-tools to work around it:
> http://en.opensuse.org/Reduce_laptop_APM_loadcycle
> But i have only found this webpage a few days ago.
> The value 254 seems to work fine.

I'm not sure I should be adding cases where the drive has been replaced.
 Hmm.. we definitely need something more dynamic.  I'll keep you
informed on progress.

Thanks.

-- 
tejun
