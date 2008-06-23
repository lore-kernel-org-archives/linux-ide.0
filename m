From: "Milo Medin" <medin@m2znetworks.com>
Subject: FW: ICH10R PMP support
Date: Sun, 22 Jun 2008 20:04:23 -0700
Message-ID: <023701c8d4dd$d737fa10$85a7ee30$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exsmtp012-1.exch012.intermedia.net ([64.78.20.147]:45004 "HELO
	exsmtp012-1.exch012.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755195AbYFWDTi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jun 2008 23:19:38 -0400
Content-Language: en-us
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mlord@pobox.com
Cc: linux-ide@vger.kernel.org

Mark, Tejun suggested I query you about your thoughts re: the Marvell 88SX7042 or the 88SE6145 SATA controllers when connected with FIS based port multipliers? 

Based on Intel's announcements last year for the ICH10R where they claimed they were going to implement FIS support for port multipliers, I had planned on rebuilding a Linux based NAS system using a P45 board and ICH10R, but it seems they didn't end up implementing FIS support in the ICH10 series after all (nice of them to neglect to mention that to the community after announcing that feature in the roadmap).  

So now I'm looking for a different solution.  I currently use SI3132 based SATA controllers, but they seem to have some performance issues, and folks seem to be reporting good performance with at least the 88SX7042 part under windows, hence the question.

Thanks in advance,
Milo


-----Original Message-----
From: Tejun Heo [mailto:tj@kernel.org] 
Sent: Sunday, June 22, 2008 4:51 PM
To: Milo Medin
Subject: Re: ICH10R PMP support

Milo Medin wrote:
> Tejun, what's your opinion of the Marvell 88SX7042 and 88SE6145
> controllers for feeding PMP's?  Do they work OK with FIS based PMP's
> in your experience?  Are they faster than the SI 3132's?

Dunno much about that chip.  You should ask Mark Lord <mlord@pobox.com>.
 Also please cc linux-ide@vger.kernel.org.

-- 
tejun

