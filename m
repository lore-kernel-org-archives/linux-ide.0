From: Denis Vlasenko <vda.linux@googlemail.com>
Subject: Re: [RFC,PATCHSET] Managed device resources
Date: Sat, 30 Dec 2006 22:31:48 +0100
Message-ID: <200612302231.48510.vda.linux@googlemail.com>
References: <1167146313307-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030349AbWL3VdF@vger.kernel.org>
In-Reply-To: <1167146313307-git-send-email-htejun@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: gregkh@suse.de, jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tuesday 26 December 2006 16:18, Tejun Heo wrote:
> Hello, all.
> 
> This patchset implements managed device resources, in short, devres.

I was working on a Linux device driver. Indeed, those error paths
are notoriously prone to bugs.

Patchset looks like good idea to me.
--
vda
