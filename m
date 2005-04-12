From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: 'hdparm -C' problems with libata-dev
Date: Tue, 12 Apr 2005 16:55:48 -0400
Message-ID: <87f94c370504121355e9231e2@mail.gmail.com>
References: <42568F29.6020800@nv-systems.net>
	 <20050412140002.GC27920@tuxdriver.com>
Reply-To: Greg Freemyer <greg.freemyer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:54003 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262947AbVDLUzt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Apr 2005 16:55:49 -0400
Received: by wproxy.gmail.com with SMTP id 67so3703257wri
        for <linux-ide@vger.kernel.org>; Tue, 12 Apr 2005 13:55:48 -0700 (PDT)
In-Reply-To: <20050412140002.GC27920@tuxdriver.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Apr 12, 2005 10:00 AM, John W. Linville <linville@tuxdriver.com> wrote:
> On Fri, Apr 08, 2005 at 04:03:21PM +0200, Gerald Hopf wrote:
> 
> > Is there anything i can do to make this ('hdparm -C') work? Is this a
> > libata bug or missing feature? A Seagate Firmware bug? A hdparm problem?
> > Or just not possible with SATA Drives?
> 
> Sounds like a bug w/ my implementation of HDIO_DRIVE_CMD for libata.
> However, I have yet to take the opportunity to track it down.  Plus,
> I'll be taking a little vacation over the coming weekend, so I likely
> won't get to this until sometime next week... :-(
> 
> Until then, please feel free to experiment more w/ hdparm to see if
> there are any other problems w/ hdparm on SATA.  Please copy me on
> reports of any such problems (or send them to me directly).  Thanks!
> 
> John
> --
> John W. Linville
> linville@tuxdriver.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I reported that "hdparm -r" was not working with PATA drives a couple
months ago.  I got no feedback, but if someone can test it with SATA I
would be curious if it works.

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
