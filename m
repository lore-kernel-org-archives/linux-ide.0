From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] libata-tj-stable against v2.6.17.4 available
Date: Mon, 10 Jul 2006 23:15:33 +0900
Message-ID: <44B26105.9080105@gmail.com>
References: <20060708123242.GE2592@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030397AbWGJOOg@vger.kernel.org>
In-Reply-To: <20060708123242.GE2592@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Updated version available.

* Link resume handling in the previous version was broken causing libata 
to ignore hotplug event after a link has been hot-unplugged.  Fixed.

* A few other hotplug related problems are fixed.

I expect this version to have well-behaving PMP and hotplug support. If 
anything seems weird, please report.

More info can be found at the following URL.

http://home-tj.org/wiki/index.php/Libata-tj-stable

Updated patches against v2.6.17.4 are at the following URL.

http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060710.tar.bz2 


Thanks.

-- 
tejun
