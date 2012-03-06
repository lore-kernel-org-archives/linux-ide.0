From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2 0/3] ahci: fix boot/resume COMRESET failures
Date: Tue, 6 Mar 2012 10:24:14 -0800
Message-ID: <CAN8TOE-OgUC+W12D1KkS2rpziYP1bgaF7CfP6fnYHJWsFZ=Hfg@mail.gmail.com>
References: <1329849524-23758-1-git-send-email-computersforpeace@gmail.com>
	<20120223000240.GA1931@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120223000240.GA1931@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Norbert Preining <preining@logic.at>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Lin Ming <ming.m.lin@intel.com>, "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Valdis Kletnieks <valdis.kletnieks@vt.edu>, "Rafael J . Wysocki" <rjw@sisk.pl>
List-Id: linux-ide@vger.kernel.org

Hi Jeff,

On Wed, Feb 22, 2012 at 4:02 PM, Norbert Preining <preining@logic.at> w=
rote:
> On Di, 21 Feb 2012, Brian Norris wrote:
>> This series addresses regression problems with
>>
>> =A0 =A0 commit 7faa33da9b7add01db9f1ad92c6a5d9145e940a7
>> =A0 =A0 ahci: start engine only during soft/hard resets
>>
>> Because the fix provided by the above commit caused COMRESET failure=
s and
>> 10 second boot-time/resume-time hangs for certain DVD drives, we nee=
d to
>> make the fix conditional to certain devices/platforms. Add a flag fo=
r this.
>
> I confirm that these patches without the previous fix also
> fixes the regression I have seen. Thanks.

Shouldn't this patch series be sent mainline during the 3.3 cycle?

Brian
