From: "yong xue" <ultraice@gmail.com>
Subject: Re: pci_get_device_reverse(), why does Calgary need this?
Date: Fri, 15 Feb 2008 23:46:06 +0800
Message-ID: <f20f12900802150746t6117e5cexa06ec4516e44100b@mail.gmail.com>
References: <20080213001506.GA13933@kroah.com>
	 <20080213001638.GB13933@kroah.com>
	 <20080213093225.GA16985@rhun.haifa.ibm.com>
	 <20080213173203.GC10733@kroah.com>
	 <20080213174711.GB22274@rhun.haifa.ibm.com>
	 <20080213181459.GA8960@kroah.com> <20080215071703.GA9022@kroah.com>
	 <20080215074827.GE4334@rhun.haifa.ibm.com>
	 <20080215152008.GA1975@kroah.com>
	 <20080215153140.GN1178@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:11696 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbYBOPqK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 10:46:10 -0500
Received: by py-out-1112.google.com with SMTP id u52so919514pyb.10
        for <linux-ide@vger.kernel.org>; Fri, 15 Feb 2008 07:46:07 -0800 (PST)
In-Reply-To: <20080215153140.GN1178@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Greg KH <greg@kroah.com>, Muli Ben-Yehuda <muli@il.ibm.com>, jdmason@kudzu.us, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

2008/2/15, Sam Ravnborg <sam@ravnborg.org>:
> On Fri, Feb 15, 2008 at 07:20:08AM -0800, Greg KH wrote:
>  > On Fri, Feb 15, 2008 at 09:48:27AM +0200, Muli Ben-Yehuda wrote:
>  > > In conclusion, our usage doesn't seem lika a good fit for the probe
>  > > approach, although it could probably converted provided we got the
>  > > ordering right with regards to regular PCI device
>  > > initialization. Doesn't seem to be worth the effort.
>  >
>  > After reading this, and looking at the code again, I agree.  Thanks for
>  > the great explaination, I'll leave the code alone now :)
>
>
> Copy the nice explanation from the mail into the code as a comment
>  somewhere?
>         Sam

I think  it is good  to do so.

xueyong
>
> -
>  To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
