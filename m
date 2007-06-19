From: Vlad <vladc6@yahoo.com>
Subject: Pioneer DVR-111 problems with DMA
Date: Tue, 19 Jun 2007 01:55:38 -0700 (PDT)
Message-ID: <560608.38945.qm@web54404.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web54404.mail.yahoo.com ([206.190.49.134]:23629 "HELO
	web54404.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755028AbXFSJCU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jun 2007 05:02:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: amills@acpmagazines.com.au

Hi,

I'd like to bring to your attention an article that claims the Pioneer
DVR-111 drive doesn't work with libata because the drive needs the
nodma option:

http://apcmag.com/6415/first_look_at_fedora_core_7
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=242956

The drive was released recently (around 2006). Perhaps it should be
added to the blacklist?

Thanks,
Vlad 


       
____________________________________________________________________________________
Boardwalk for $500? In 2007? Ha! Play Monopoly Here and Now (it's updated for today's economy) at Yahoo! Games.
http://get.games.yahoo.com/proddesc?gamekey=monopolyherenow  
